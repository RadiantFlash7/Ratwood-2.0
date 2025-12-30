/turf
	///Default probatility of leaving a track when entering this turf
	var/track_prob = 0

//Base probabilities to leave a track.
/turf/open/floor/rogue/dirt
	track_prob = 10

/turf/open/floor/rogue/grass
	track_prob = 10

/turf/open/floor/rogue/grassyel
	track_prob = 10

/turf/open/floor/rogue/grassred
	track_prob = 10

/turf/open/floor/rogue/grasscold
	track_prob = 10

/turf/open/floor/rogue/snow
	track_prob = 20

/turf/open/floor/rogue/AzureSand
	track_prob = 20

/turf/open/floor/rogue/snowrough
	track_prob = 10

/turf/open/floor/carpet
	track_prob = 10

/turf/open/floor/rogue/wood
	track_prob = 5

/turf/open/floor/rogue/dirt/road
	track_prob = 10

/turf/open/floor/rogue/concrete
	track_prob = 5

/turf/open/floor/rogue/rooftop
	track_prob = 10

/turf/open/floor/rogue/cobble
	track_prob = 3

/turf/open/floor/rogue/blocks
	track_prob = 10

/turf/open/floor/rogue/tile/bath
	track_prob = 20

/turf/open/floor/rogue/tile
	track_prob = 10

/turf/open/floor/rogue/hexstone
	track_prob = 10

/turf/open/floor/rogue/churchmarble
	track_prob = 5

/turf/open/floor/rogue/churchbrick
	track_prob = 5

/turf/open/floor/rogue/cobblerock
	track_prob = 10

//Probabilities end (albeit mud is handled seperately).

//For highlighting tracks
/mob/living/carbon/human
	var/mob/living/current_mark

//Analysis levels depending on skillcheck during reveal.
#define ANALYSIS_TERRIBLE 1
#define ANALYSIS_BAD 2
#define ANALYSIS_DECENT 3
#define ANALYSIS_GOOD 4
#define ANALYSIS_PERFECT 5

/obj/effect/track
	name = "\improper track"
	desc = null
	anchored = TRUE
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	invisibility = INVISIBILITY_MAXIMUM
	icon = 'modular_hearthstone/icons/obj/effects/track.dmi' //This sucks, but too bad!
	///The visible state for those that know this.
	var/real_icon_state = "tracks"
	///The image knowers see.
	var/real_image
	///List of mobs aware of this track.
	var/list/mob/living/known_by = list()
	///When this was created. Adjusts difficulty of locating / analyzing.
	var/creation_time = 0
	///What kind of foot, or footwear, created this.
	var/track_type = "codersock tracks"
	///Like above, except what you get if you are not good.
	var/ambiguous_track_type = "footwear tracks"
	///The way the mob was facing when this was created. Obviously can be messed with if you e.g. walk backwards.
	var/facing = "nowhere"
	///If the depth of the tracks is abnormal, e.g. because of heavy armor.
	var/depth
	///If the creator was moving in a special way, e.g. running / sneaking. Difficult to discern.
	var/special_movement
	///The exact mob that created this. Only used to see if the spotter can notice their own tracks (fairly easy)
	var/mob/living/creator
	///Some things may be easier or harder to track. This adjusts the base difficulty accordingly.
	var/tracking_modifier = 0
	///Tracks how many tracks have been chain-overwritten before this track. Could indicate a commonly passed area.
	var/overwrites = 0
	///The timer handling deletion. Saved to potentially adjust it.
	var/deletion_timer
	///For determining if it's been highlighted for marked person purposes
	var/highlighted = list()
	///A preserved dir for the highlights
	var/original_dir
	///Whether this track allows its owner to be Marked
	var/markable = TRUE
	///Base difficulty for noticing these tracks
	var/base_diff = 11

/obj/effect/track/Initialize()
	. = ..()
	real_image = image(icon, src, real_icon_state, ABOVE_OPEN_TURF_LAYER) //Default image in case manually created.

/obj/effect/track/Destroy(force)
	real_image = null
	for(var/knowing_one as anything in known_by)
		remove_knower(knowing_one)
	if(creator)
		clear_creator_reference(creator)
	known_by = null
	if(deletion_timer)
		deltimer(deletion_timer)
		deletion_timer = null
	return ..()

/obj/effect/track/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	to_chat(user, span_info("You start concealing the tracks.."))
	if(!do_after(user, 4 SECONDS, target = src))
		return
	to_chat(user, span_warning("Nobody should be able to follow these tracks anymore.."))
	qdel(src)
	return TRUE

///Handles checks for if a mob can reveal this. Also returns FALSE if already known to mob.
/obj/effect/track/proc/check_reveal(mob/living/user)
	if(user in known_by)
		return FALSE
	var/success = FALSE
	if(!HAS_TRAIT(user, TRAIT_PERFECT_TRACKER))
		var/diff = base_diff //Base Tracking Difficulty
		diff += tracking_modifier
		diff += round((world.time - creation_time) / (60 SECONDS), 1) //Gets more difficult to spot the older.
		diff += rand(0, 5) //Entropy.

		var/competence = user.STAPER
		if(user.mind)
			competence += 2 * user.get_skill_level(/datum/skill/misc/tracking)

		if(competence >= diff)
			success = TRUE
		else if(diff - competence < 5)
			success = prob((100 - ((diff - competence) * 20)))
	else
		success = TRUE
	if(success && user.mind && creator != user)
		user.mind.add_sleep_experience(/datum/skill/misc/tracking, (user.STAINT*2))
	return success

///Handles revealing the track, including checking how well the tracker can analyze it.
/obj/effect/track/proc/handle_revealing(mob/living/user)
	//Second layer of skill check: How much knowledge you get.
	var/analysis_result = 0
	if(!HAS_TRAIT(user, TRAIT_PERFECT_TRACKER))
		var/diff = 0
		diff += tracking_modifier
		diff += round((world.time - creation_time) / (60 SECONDS), 1)
		var/competence = abs(user.STAPER - 5)
		if(user.mind)
			competence += 5 * user.get_skill_level(/datum/skill/misc/tracking) //Skill is much more relevant for analysis.
		switch(competence - diff)
			if(30 to INFINITY)
				analysis_result = ANALYSIS_PERFECT
			if(20 to 29)
				analysis_result = ANALYSIS_GOOD
			if(10 to 19)
				analysis_result = ANALYSIS_DECENT
			if(0 to 9)
				analysis_result = ANALYSIS_BAD
			if(-INFINITY to 0)
				analysis_result = ANALYSIS_TERRIBLE
	else
		analysis_result = ANALYSIS_PERFECT
	add_knower(user, analysis_result)

//Handles value settings done for a track that need to be done.
/obj/effect/track/proc/handle_creation(mob/living/track_source)
	creator = track_source
	RegisterSignal(track_source, COMSIG_PARENT_QDELETING, PROC_REF(clear_creator_reference))
	creation_time = world.time
	track_source.get_track_info(src)
	if(track_source.m_intent == MOVE_INTENT_SNEAK)
		special_movement = "Their creator appears to have been sneaking.."
	else if(track_source.m_intent == MOVE_INTENT_RUN)
		special_movement = "Their creator appears to have been running!"
	switch(track_source.dir)
		if(NORTH)
			facing = "north"
		if(SOUTH)
			facing = "south"
		if(EAST)
			facing = "east"
		if(WEST)
			facing = "west"
		if(NORTHWEST)
			facing = "northwest"
		if(NORTHEAST)
			facing = "northeast"
		if(SOUTHWEST)
			facing = "southwest"
		if(SOUTHEAST)
			facing = "southeast"
	real_image = image(icon, src, real_icon_state, ABOVE_OPEN_TURF_LAYER, track_source.dir) //Recreate image with correct dir.
	original_dir = track_source.dir
	deletion_timer = addtimer(CALLBACK(src, PROC_REF(track_expire)), 15 MINUTES, TIMER_STOPPABLE) //Tracks naturally expire after 15 minutes (although at that point their DC is pretty high anyways.)

///Adds a new person to the list of people who can see this track.
/obj/effect/track/proc/add_knower(mob/living/tracker, competence = 1)
	known_by[tracker] = competence
	if(ishuman(tracker))
		var/mob/living/carbon/human/H = tracker
		if(HAS_TRAIT(tracker, TRAIT_SLEUTH) && H.current_mark == creator)
			if(!(tracker in highlighted))
				real_icon_state = "tracks_marked"
				real_image = image(icon, src, real_icon_state, ABOVE_OPEN_TURF_LAYER, original_dir)
				LAZYADD(highlighted, tracker)
		if(tracker.client)
			tracker.client.images += real_image
	RegisterSignal(tracker, COMSIG_PARENT_QDELETING, PROC_REF(remove_knower), override = TRUE)

///Removes a knower from the known ones. Usually only done when qdeleted.
/obj/effect/track/proc/remove_knower(mob/living/tracker)
	SIGNAL_HANDLER
	UnregisterSignal(tracker, COMSIG_PARENT_QDELETING)
	if(tracker.client)
		tracker.client.images -= real_image
	LAZYREMOVE(highlighted, tracker)
	known_by -= tracker
	if(creator == tracker)
		creator = null

///Clears the reference to the creator. Is replaced by the above proc if the creator analyzes it.
/obj/effect/track/proc/clear_creator_reference(mob/living/creator_arg)
	SIGNAL_HANDLER
	UnregisterSignal(creator, COMSIG_PARENT_QDELETING)
	creator = null

///Called when the track's time expires, at which point it becomes indistinguishable (aka, deleted)
/obj/effect/track/proc/track_expire()
	qdel(src)

/obj/effect/track/examine(mob/user)
	. = ..()
	var/knowledge = known_by[user]
	if(!knowledge)
		return //Huh?
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(!isnull(H.current_mark))
			if(H.current_mark == creator && !(H in highlighted))
				real_icon_state = "tracks_marked"
				real_image = image(icon, src, real_icon_state, ABOVE_OPEN_TURF_LAYER, original_dir)
				LAZYADD(highlighted, H)
				if(H.client)
					H.client.images += real_image
	. += knowledge_readout(user, knowledge)

/obj/effect/track/proc/knowledge_readout(mob/user, knowledge)
	if(knowledge >= ANALYSIS_DECENT)
		. += "Looks like some [track_type].<br>"
	else
		. += "Looks like some [ambiguous_track_type].<br>"
	. += "This track leads [facing].<br>"
	if(knowledge > ANALYSIS_DECENT)
		var/timepassed = ((world.time - creation_time) * SSticker.station_time_rate_multiplier)
		var/timetext = ""
		var/realtime = round((world.time - creation_time) / 600, 1)
		if(timepassed >= 36000)
			timetext = "[round(timepassed / 36000)] hour[(round(timepassed / 36000)) == 1 ? "" : "s"]"
		else
			timetext = "[round(timepassed / 600)] minute[(round(timepassed / 600)) == 1 ? "" : "s"]"
		. += "These tracks are about [timetext] old. <i>([realtime] minute[realtime == 1 ? "" : "s"] real-time)</i><br>"
		if(depth)
			. += "These tracks are [depth]!<br>"
	if(knowledge > ANALYSIS_GOOD && special_movement)
		. += "[span_danger("[special_movement]")]<br>"
	if(knowledge > ANALYSIS_TERRIBLE && creator == user)
		. += "[span_nicegreen("These are your own tracks!")]<br>"
	if(knowledge >= ANALYSIS_GOOD)
		if(overwrites > 10)
			. += "[span_warning("There are traces of many older tracks here, too..")]<br>"
		else if(overwrites >= 2)
			. += "[span_warning("There are traces of around [overwrites] older tracks here, too..")]<br>"
		var/mob/living/carbon/human/H = user
		if(!isnull(H.current_mark) && H.current_mark == creator)
			. += span_nicegreen("This track belongs to your mark.")
		if(H.get_skill_level(/datum/skill/misc/tracking) >= SKILL_LEVEL_EXPERT)
			. += span_nicegreen("<i><font size = 2>Right-click this track to Mark its owner.</font></i>")
	return .

///Gets special info for a track relative to a mob, such as type and depth. Override if desiring tracking modifier adjustment.
/mob/living/proc/get_track_info(obj/effect/track/this_track)
	var/mob/living/prototype = type
	this_track.track_type = "[initial(prototype.name)] tracks" //Lets not mess with someone naming their mob.
	this_track.ambiguous_track_type = "beast tracks" //Override proc if your mob has weird tracks.

/mob/living/carbon/human/get_track_info(obj/effect/track/this_track)
	if(istype(this_track,/obj/effect/track/structure))
		var/holding = get_active_held_item()
		var/obj/effect/track/structure/this = this_track
		var/weapon
		if(holding)
			if(istype(holding,/obj/item/rogueweapon))
				var/static/list/weapon_types = list(/obj/item/rogueweapon/sword, /obj/item/rogueweapon/mace, /obj/item/rogueweapon/spear, /obj/item/rogueweapon/greatsword, /obj/item/rogueweapon/pick, /obj/item/rogueweapon/huntingknife/idagger, /obj/item/rogueweapon/whip, /obj/item/lockpick)
				for(var/type in weapon_types)
					if(istype(holding, type))
						var/obj/item/rogueweapon/found = type
						weapon = initial(found.name)

			if(weapon)
				this.tool_used_ambiguous = weapon
			var/obj/item/I = holding
			var/skill = I.associated_skill
			this.tool_used = I.name
			if(skill)
				this.skill_level = get_skill_level(skill)
	else
		if(!(mobility_flags & MOBILITY_STAND)) //Either pulled or crawling.
			this_track.track_type = "drag marks"
			this_track.track_type = "drag marks"
		else
			if(shoes && (shoes.body_parts_covered & FEET))
				this_track.track_type = "[shoes.name] tracks"
				this_track.ambiguous_track_type = "footwear tracks"
			else
				this_track.track_type = "[dna.species.name] footprints" //Look, I am not going to track the species of every single leg you do surgical malpractice with, so this will do.
				this_track.ambiguous_track_type = "humanoid footprints"

		var/bonus_weight = 0
		if(wear_armor)
			switch(wear_armor.armor_class)
				if(ARMOR_CLASS_HEAVY)
					bonus_weight += 1
				if(ARMOR_CLASS_MEDIUM)
					bonus_weight = 0.5
				else
		if(wear_shirt)
			switch(wear_shirt.armor_class)
				if(ARMOR_CLASS_HEAVY)
					bonus_weight += 1
				if(ARMOR_CLASS_MEDIUM)
					bonus_weight = 0.5
				else
		switch(bonus_weight)
			if(2 to INFINITY)
				this_track.depth = "very deep"
			if(1 to 2)
				this_track.depth = "deep"
			else
	return //This is needed at the moment.

//Checks if the mob should create a track, and creates one if the case (potentially replacing older tracks on the turf)
/mob/living/proc/check_track_creation(turf/new_turf)
	if(!new_turf)
		return //Guh?
	if(isnull(mind))
		return
	if(istype(src, /mob/living/simple_animal))
		return // animals don't create forensic tracks
	if(!(movement_type & GROUND) || (movement_type & (FLOATING|FLYING))) //For some reason some mobs have both ground and flying at once.
		return
	var/probability = round(track_creation_prob(new_turf), 0.1)
	if(!probability)
		return
	if(!prob(probability))
		return
	var/obj/effect/track/old_track = locate() in new_turf
	var/obj/effect/track/new_track = new(new_turf)
	if(old_track)
		new_track.overwrites = 1 + old_track.overwrites
		qdel(old_track)
	new_track.handle_creation(src)

//Gets the probability of this mob to create a track on the passed turf.
/mob/living/proc/track_creation_prob(turf/new_turf)
	. = new_turf.track_prob
	if(!.)
		return 0
	if(m_intent == MOVE_INTENT_SNEAK)
		var/remaining_mod = 0.7
		if(mind)
			remaining_mod -= 0.1 * get_skill_level(/datum/skill/misc/sneaking)
		. *= remaining_mod
	else if(m_intent == MOVE_INTENT_RUN)
		. *= 3

/mob/living/carbon/human/track_creation_prob(turf/new_turf)
	. = ..()
	if(!.)
		return
	var/bonus_weight = 0
	if(wear_armor)
		switch(wear_armor.armor_class)
			if(ARMOR_CLASS_HEAVY)
				bonus_weight += 0.5
			if(ARMOR_CLASS_MEDIUM)
				bonus_weight = 0.25
			else
	if(wear_shirt)
		switch(wear_shirt.armor_class)
			if(ARMOR_CLASS_HEAVY)
				bonus_weight += 0.5
			if(ARMOR_CLASS_MEDIUM)
				bonus_weight = 0.25
	if(bonus_weight)
		. *= (1 + bonus_weight)

/obj/effect/track/structure
	name = "clue"
	real_icon_state = "tracks_structure"
	markable = FALSE
	var/skill_level
	var/tool_used
	var/tool_used_ambiguous
	var/is_silver

/obj/effect/track/structure/handle_creation(mob/living/track_source)
	creator = track_source
	RegisterSignal(track_source, COMSIG_PARENT_QDELETING, PROC_REF(clear_creator_reference))
	creation_time = world.time
	track_source.get_track_info(src)
	real_image = image(icon, src, real_icon_state, ABOVE_OPEN_TURF_LAYER, track_source.dir)
	deletion_timer = addtimer(CALLBACK(src, PROC_REF(track_expire)), 15 MINUTES, TIMER_STOPPABLE)

/obj/effect/track/structure/knowledge_readout(mob/user, knowledge)
	if(tool_used_ambiguous)
		. += "Looks like the marks of some kind of \the <font color = '#0d5381'>[tool_used_ambiguous]</font><br>"
	else if(!tool_used)
		. += "I have no clue what broke this."
	if(knowledge > ANALYSIS_TERRIBLE && creator == user)
		. += "[span_nicegreen("These are your own tracks!")]<br>"
	if(knowledge < ANALYSIS_DECENT)
		return .
	if(knowledge > ANALYSIS_DECENT)
		var/timepassed = ((world.time - creation_time) * SSticker.station_time_rate_multiplier)
		var/timetext = ""
		var/realtime = round((world.time - creation_time) / 600, 1)
		if(timepassed >= 36000)
			timetext = "[round(timepassed / 36000)] hour[(round(timepassed / 36000)) == 1 ? "" : "s"]"
		else
			timetext = "[round(timepassed / 600)] minute[(round(timepassed / 600)) == 1 ? "" : "s"]"
		. += "These tracks are about [timetext] old. <i>([realtime] minute[realtime == 1 ? "" : "s"] real-time)</i><br>"
	if(knowledge >= ANALYSIS_GOOD)
		if(skill_level)
			. += "The person was at <font color = '#ebebeb'>[SSskills.level_names_plain[skill_level]]</font> skill level with this item.<br>"
	if(knowledge >= ANALYSIS_PERFECT)
		. += "It looks to be the distinct markings of \the <font color = '#5ca2d1'>[tool_used].</font><br>"
	return .

/obj/effect/track/structure/attack_right(mob/user)
	to_chat(user,span_info("You can't distinguish an object like this."))
	return

/obj/effect/track/attack_right(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.get_skill_level(/datum/skill/misc/tracking) > SKILL_LEVEL_JOURNEYMAN)	//Expert+
			if(!markable)
				to_chat(H, span_warning("This is not enough to Mark them. I need proper tracks."))
			to_chat(H, span_info("You start taking note of the person's gait, weight and other distinct features."))
			if(do_after(user, (50 - H.STAPER*2)))
				H.current_mark = creator
				to_chat(H, span_warning("You've marked this person. You'll notice their tracks if you find any new ones."))
		else
			to_chat(H, span_info("I am not skilled enough for this! (Expert level required)"))

/obj/effect/track/thievescant
	name = "engraved symbols"
	gender = PLURAL
	real_icon_state = "thieves_cant"
	markable = FALSE
	base_diff = 5 //Easier to notice
	var/message

/obj/effect/track/thievescant/handle_creation(mob/living/track_source, thiefmessage)
	creator = track_source
	RegisterSignal(track_source, COMSIG_PARENT_QDELETING, PROC_REF(clear_creator_reference))
	creation_time = world.time
	track_source.get_track_info(src)
	real_image = image(icon, src, real_icon_state, BULLET_HOLE_LAYER, track_source.dir)
	alpha = 128
	message = thiefmessage

/obj/effect/track/thievescant/knowledge_readout(mob/user, knowledge)
	if(!user.has_language(/datum/language/thievescant))
		. += "Looks like a bunch of meaningless engravings..."
	else
		. += "An engraved message left by [creator == user ? "me" : "one of my fellows"]. It reads...<br>"
		. += "<font color = '#0d5381'>\"[message]\"</font>"

	return .

/obj/effect/track/thievescant/attack_right(mob/user)
	to_chat(user,span_info("You can't distinguish an object like this."))
	return


GLOBAL_LIST_INIT(active_hunts, list())

/proc/get_active_hunt_for(mob/living/carbon/human/H)
	for(var/datum/hunt_instance/HUNT in GLOB.active_hunts)
		if(HUNT.tracker == H && HUNT.active_track)
			return HUNT
	return null

//Hunting related tracking below

/datum/hunt_instance
	var/mob/living/carbon/human/tracker
	var/animal_type
	var/current_step = 0
	var/max_steps = 5
	var/last_turf
	var/started = FALSE
	var/is_abnormal = FALSE
	var/active_track // the most recent track object
	var/last_attempt = 0

/datum/hunt_instance/New(mob/living/carbon/human/H, animal_type)
	tracker = H
	src.animal_type = animal_type
	max_steps = rand(4,5)
	is_abnormal = HAS_TRAIT(H, TRAIT_VETERANHUNTER)
	GLOB.active_hunts += src

/datum/hunt_instance/proc/end_hunt(message)
	if(tracker)
		to_chat(tracker, span_warning(message))

	GLOB.active_hunts -= src
	tracker = null
	active_track = null
	qdel(src)

/mob/living/carbon/human/proc/try_start_animal_hunt()
	var/mob/living/carbon/human/H = src

	// Soft chance, scales with skill
	var/chance = 10 + (H.get_skill_level(/datum/skill/misc/tracking) * 15)

	if(!prob(chance))
		to_chat(H, span_info("The area seems almost barren..."))
		return

	var/list/animals = list(
		/mob/living/simple_animal/hostile/retaliate/rogue/saiga,
		/mob/living/simple_animal/hostile/retaliate/rogue/goat,
		/mob/living/simple_animal/hostile/retaliate/rogue/direbear,
		/mob/living/simple_animal/hostile/retaliate/rogue/swine
	)

	var/datum/hunt_instance/HUNT = new(H, pick(animals))

	to_chat(H, span_info("You notice signs of animal movement nearby..."))

	HUNT.create_initial_hunt_track(get_turf(H))

/obj/effect/track/animal
	name = "animal tracks"
	markable = FALSE
	track_type = "animal tracks"
	ambiguous_track_type = "beast tracks"
	real_icon_state = "animaltracks"
	var/datum/hunt_instance/hunt// Hunt linkage
	var/hunt_step = 0
	// Animal-specific tuning
	base_diff = 9          // Easier than humanoids
	tracking_modifier = -2 // Wilderness advantage
	invisibility = INVISIBILITY_MAXIMUM
	alpha = 0

/obj/effect/track/animal/proc/reveal_to(mob/living/carbon/human/H)
	if(!(H in known_by))
		known_by += H

	invisibility = 0
	alpha = 255

/obj/effect/track/animal/handle_creation(mob/living/track_source)
	creation_time = world.time
	creator = null
	original_dir = pick(NORTH, SOUTH, EAST, WEST)
	real_image = image(icon, src, real_icon_state, ABOVE_OPEN_TURF_LAYER, original_dir)
	deletion_timer = addtimer(CALLBACK(src, PROC_REF(track_expire)), 20 SECONDS, TIMER_STOPPABLE)

/obj/effect/track/animal/knowledge_readout(mob/user, knowledge)
	. = ""

	if(knowledge >= ANALYSIS_DECENT)
		. += "These look like animal tracks.<br>"
	else
		. += "Some kind of beast passed through here.<br>"
	. += "They lead [facing].<br>"

	if(knowledge >= ANALYSIS_GOOD)
		. += "The tracks are fresh and purposeful.<br>"
	if(knowledge >= ANALYSIS_PERFECT)
		. += "You're certain this trail can be followed.<br>"
	return .

/obj/effect/track/animal/examine(mob/user)
	. = ..()
	if(!hunt)
		return
	if(!(user in known_by))
		return
	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user
	if(H != hunt.tracker)
		return

	if(get_dist(H, src) > 1)
		to_chat(H, span_warning("You need to be closer to properly read these tracks."))
		return

	to_chat(H, span_notice("You kneel down to study the tracks..."))
	if(!do_after(H, 2 SECONDS, src))
		to_chat(H, span_warning("You lose focus and the trail slips away."))
		return

	if(!hunt || QDELETED(src))// Recheck validity after delay
		return

	if(hunt.active_track != src)
		return

	advance_hunt(H)

/obj/effect/track/animal/track_expire()
	if(hunt && hunt.active_track == src)// Only end the hunt if THIS was the active track
		terminate_hunt_boundary()

	qdel(src)

/obj/effect/track/animal/proc/advance_hunt(mob/living/carbon/human/H)
	if(hunt_step >= hunt.max_steps)
		spawn_hunted_animal()
		hunt.end_hunt("The trail ends here.")
		return
	hunt.spawn_next_hunt_track(src)
	qdel(src)

/datum/hunt_instance/proc/find_next_hunt_turf(turf/origin, dir)
	var/step_distance = 6
	var/angle_offset = rand(-30, 30) // mimic natural pathing

	var/dir_angle = dir_to_angle(dir) + angle_offset
	var/dx = round(step_distance * cos(dir_angle))
	var/dy = round(step_distance * sin(dir_angle))

	var/turf/T = locate(origin.x + dx, origin.y + dy, origin.z)

	if(T && can_hunt_in_turf(T) && !is_obstructed(T))	// Ensure the turf exists, can be hunted, and is free of obstructions
		return T

	// If blocked, try orthogonal directions
	var/list/orth_dirs = list(turn(dir, 90), turn(dir, -90))
	for(var/orth_dir in orth_dirs)
		var/oa = dir_to_angle(orth_dir) + angle_offset
		var/odx = round(step_distance * cos(oa))
		var/ody = round(step_distance * sin(oa))

		var/turf/O = locate(origin.x + odx, origin.y + ody, origin.z)
		if(O && can_hunt_in_turf(O) && !is_obstructed(O))
			return O
	return null

/datum/hunt_instance/proc/is_obstructed(turf/T)
	// Check for structures, items, or terrain that should block tracks
	for(var/obj/O in T.contents)
		if(istype(O, /obj/structure))
			return TRUE
	// You could also add terrain checks here if certain turfs block hunting
	return FALSE

/datum/hunt_instance/proc/spawn_next_hunt_track(obj/effect/track/animal/old)
	var/datum/hunt_instance/H = old.hunt
	if(!H)
		return

	var/turf/next = find_next_hunt_turf(old.loc, old.original_dir)
	if(!next)
		old.terminate_hunt_boundary()
		return

	var/obj/effect/track/animal/new_track = new(next)
	new_track.hunt = H
	new_track.hunt_step = old.hunt_step + 1
	new_track.original_dir = old.original_dir
	new_track.facing = dir2text(old.original_dir)
	new_track.reveal_to(H.tracker)
	H.active_track = new_track
	H.current_step = new_track.hunt_step
	H.last_turf = next

/obj/effect/track/animal/proc/terminate_hunt_boundary()
	if(!hunt)
		return

	var/mob/living/carbon/human/H = hunt.tracker
	if(H)
		to_chat(H, span_warning("The tracks fade as signs of civilization take over. The animal must have fled elsewhere."))
	hunt = null

/datum/hunt_instance/proc/create_initial_hunt_track(turf/T)
	if(!can_hunt_in_turf(T))
		return
	var/obj/effect/track/animal/tracked = new(T)
	tracked.hunt = src
	tracked.hunt_step = 1
	tracked.original_dir = pick(NORTH, SOUTH, EAST, WEST)
	tracked.facing = dir2text(tracked.original_dir)
	tracked.reveal_to(tracker)

	active_track = tracked
	last_turf = T
	current_step = 1

/proc/can_hunt_in_turf(turf/T)
	var/area/A = T.loc
	if(!A || !A.allow_hunting)
		return FALSE
	return TRUE

/datum/hunt_instance/proc/apply_bonus_loot(list/butcher_list, list/bonus)
	if(!bonus)
		return

	for(var/path in bonus)
		butcher_list[path] = (butcher_list[path] || 0) + bonus[path]

/obj/effect/track/animal/proc/spawn_hunted_animal()
	if(!hunt)
		return

	var/turf/T = hunt.last_turf
	if(!T)
		return

	var/mob/living/simple_animal/A = new hunt.animal_type(T)

	if(hunt.is_abnormal)
		A.name = "abnormally large [A.name]"
		A.maxHealth *= 2
		A.Health *= 2
		apply_bonus_loot(A.butcher_results, hunt_bonus)

	if(hunt.tracker)
		to_chat(hunt.tracker, span_danger("The trail ends here the animal is close!"))

/proc/dir_to_angle(dir)
	switch(dir)
		if(NORTH) return 90
		if(SOUTH) return 270
		if(EAST)  return 0
		if(WEST)  return 180
		if(NORTHEAST) return 45
		if(NORTHWEST) return 135
		if(SOUTHEAST) return 315
		if(SOUTHWEST) return 225
	return 0

#undef ANALYSIS_TERRIBLE
#undef ANALYSIS_BAD
#undef ANALYSIS_DECENT
#undef ANALYSIS_GOOD
#undef ANALYSIS_PERFECT