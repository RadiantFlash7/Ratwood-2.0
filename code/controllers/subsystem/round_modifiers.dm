#define ANTAG_TIER_MINOR 1
#define ANTAG_TIER_MEDIUM 2
#define ANTAG_TIER_MAJOR 3

/datum/controller/subsystem/gamemode
	var/level = 2
	var/budget = 0
	var/list/active_modifiers = list()
	var/modifiers_rolled = FALSE
	var/list/draw_flags

/datum/controller/subsystem/gamemode/proc/chaos_vote_result(winner)
	switch(winner)
		if("Adventure")
			level = 0
		if("Chaos")
			var/players = length(GLOB.new_player_list)
			if(players >= 140)
				level = 3
			else if(players >= 120)
				level = 2
			else
				level = 1
	if(level >= 3 && SSpersistence.last_chaos_level >= 3)
		level = 2
	SSpersistence.SaveChaosLevel(level)
	to_chat(world, span_notice("<b>[winner]!</b>"))
	roll_round_modifiers()

/datum/controller/subsystem/gamemode/proc/roll_round_modifiers()
	if(modifiers_rolled)
		return
	modifiers_rolled = TRUE

	if(istype(SSvote.current_vote, /datum/vote/chaos))
		SSvote.end_vote()

	switch(level)
		if(0)
			active_modifiers += new /datum/round_modifier/adventure
		if(1)
			budget = rand(2, 5)
		if(2)
			budget = rand(6, 8)
		if(3)
			budget = rand(6, 12)

	var/list/pool = list()
	for(var/T in subtypesof(/datum/round_modifier))
		var/datum/round_modifier/M = new T
		if(level < M.min_chaos || level > M.max_chaos)
			continue
		if(!M.tier && (length(M.job_slots) || length(M.villain_events) || length(M.trigger_events)))
			stack_trace("[M.type] has antag content but no tier")
		if(M.tier)
			continue
		pool[M] = M.weight

	while(budget > 0 && length(pool))
		var/datum/round_modifier/M = pickweight(pool)
		pool -= M
		if(M.cost > budget)
			continue
		var/blocked = FALSE
		for(var/datum/round_modifier/other in active_modifiers)
			if((other.type in M.incompatible) || (M.type in other.incompatible))
				blocked = TRUE
				break
		if(blocked)
			continue
		budget -= M.cost
		active_modifiers += M

	var/list/slots = list()
	var/datum/forecast/forecast = SSParticleWeather?.selected_forecast

	for(var/datum/round_modifier/M in active_modifiers)
		for(var/job_title in M.job_slots)
			slots[job_title] += M.job_slots[job_title]
		for(var/event_type in M.villain_events)
			var/datum/round_event_control/event = locate(event_type) in control
			if(event)
				rolled_villain_events |= event
		if(forecast && length(M.weather_weights))
			for(var/list/weather_list in list(forecast.day_weather, forecast.dawn_weather, forecast.dusk_weather, forecast.night_weather))
				for(var/weather_type in M.weather_weights)
					if(weather_type in weather_list)
						weather_list[weather_type] = round(weather_list[weather_type] * M.weather_weights[weather_type])

	for(var/job_title in slots)
		var/datum/job/J = SSjob.GetJob(job_title)
		if(!J)
			continue
		J.total_positions += slots[job_title]
		J.spawn_positions += slots[job_title]

	apply_modifier_effects(active_modifiers.Copy())
	announce_modifiers(active_modifiers)

/datum/controller/subsystem/gamemode/proc/is_modifier_blocked(datum/round_modifier/M)
	for(var/datum/round_modifier/other as anything in active_modifiers)
		if((other.type in M.incompatible) || (M.type in other.incompatible))
			return TRUE
	return FALSE

/datum/controller/subsystem/gamemode/proc/apply_modifier_effects(list/mods)
	var/list/slots = list()
	var/datum/forecast/forecast = SSParticleWeather?.selected_forecast
	for(var/datum/round_modifier/M as anything in mods)
		for(var/job_title in M.job_slots)
			slots[job_title] += M.job_slots[job_title]
		for(var/event_type in M.villain_events)
			var/datum/round_event_control/event = locate(event_type) in control
			if(event)
				rolled_villain_events |= event
		if(forecast && length(M.weather_weights))
			for(var/list/weather_list in list(forecast.day_weather, forecast.dawn_weather, forecast.dusk_weather, forecast.night_weather))
				for(var/weather_type in M.weather_weights)
					if(weather_type in weather_list)
						weather_list[weather_type] = round(weather_list[weather_type] * M.weather_weights[weather_type])
	for(var/job_title in slots)
		var/datum/job/J = SSjob.GetJob(job_title)
		if(!J)
			continue
		J.total_positions = max(0, J.total_positions + slots[job_title])
		J.spawn_positions = max(0, J.spawn_positions + slots[job_title])

/datum/controller/subsystem/gamemode/proc/announce_modifiers(list/mods)
	var/list/visible = list()
	for(var/datum/round_modifier/M as anything in mods)
		if(!M.hidden && !M.tier)
			visible += M
	if(!length(visible)) // no more "Nothing.": antags may still roll later, so it would be a lie
		return
	to_chat(world, span_boldnotice("Modifiers:"))
	for(var/datum/round_modifier/M as anything in visible)
		to_chat(world, span_notice("<b>[M.name]</b> - [M.desc]"))

/datum/controller/subsystem/gamemode/proc/get_antag_recipe()
	var/minor = 0
	var/medium = 0
	var/major = 0
	switch(level)
		if(1) // low: only happens under 120 players
			minor = rand(0,1)
			medium = rand(0,1)
			major = 1
		if(2) // medium
			minor = 2
			medium = rand(2,3)
			major = 1
		if(3) // high
			minor = 1
			medium = 2
			major = 2
	return list(minor, medium, major) // order matters: ANTAG_TIER (1 minor, 2 medium, 3 major)

/datum/controller/subsystem/gamemode/proc/roll_antag_modifiers()
	var/list/recipe = get_antag_recipe()
	var/list/before = active_modifiers.Copy()
	var/list/all_mods = list()
	for(var/T in subtypesof(/datum/round_modifier))
		all_mods += new T
	for(var/tier in list(ANTAG_TIER_MAJOR, ANTAG_TIER_MEDIUM, ANTAG_TIER_MINOR))
		var/want = recipe[tier]
		for(var/pass in 1 to 2) // pass 2 relaxes min_candidates to 1
			if(want <= 0)
				break
			var/list/pool = list()
			for(var/datum/round_modifier/M as anything in all_mods)
				if(M.tier != tier || level < M.min_chaos || level > M.max_chaos || (M in active_modifiers))
					continue
				if(M.count_optin_candidates() < (pass == 1 ? M.min_candidates : 1))
					continue
				pool[M] = M.weight
			while(want > 0 && length(pool))
				var/datum/round_modifier/M = pickweight(pool)
				pool -= M
				if(is_modifier_blocked(M))
					continue
				active_modifiers += M
				want--
		if(want > 0 && tier == ANTAG_TIER_MAJOR)
			message_admins("Antag roll: couldn't fill [want] major slot(s), not enough opted-in candidates.")
	var/list/rolled = active_modifiers - before
	apply_modifier_effects(rolled)
	var/list/names = list()
	for(var/datum/round_modifier/M as anything in rolled)
		names += M.name
	message_admins("Antag draw: [length(antag_optins)] opted in. Rolled: [length(names) ? names.Join(", ") : "none"]")
	log_game("ANTAG DRAW: [names.Join(", ")]")

/datum/controller/subsystem/gamemode/proc/build_draw_roles()
	if(draw_flags)
		return
	draw_flags = list()
	for(var/T in subtypesof(/datum/round_modifier))
		var/datum/round_modifier/M = new T
		if(M.tier)
			for(var/job_title in M.job_slots)
				draw_flags |= job_title // job-based roles use the be_special flag named after the job
			for(var/event_type in M.villain_events)
				var/datum/round_event_control/antagonist/solo/E = locate(event_type) in control
				if(E?.antag_flag)
					draw_flags |= E.antag_flag
		qdel(M)
