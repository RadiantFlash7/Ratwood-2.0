// a skill to help miners find medium to high quality rock and to sort out boulders before breaking them
/obj/effect/proc_holder/spell/invoked/mineroresight
	name = "Miner's Ore Sight"
	desc = "check for good ore"
	overlay_state = "analyze"
	releasedrain = 10
	chargedrain = 0
	chargetime = 0
	range = 1
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/diagnose.ogg'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 2 SECONDS //very stupidly simple spell
	miracle = FALSE
	devotion_cost = 0 //come on, this is very basic

/obj/effect/proc_holder/spell/invoked/mineroresight/cast(list/targets, mob/living/user)
	//show the miners what rock turfs are valuable
	var/skill = user.get_skill_level(/datum/skill/labor/mining)
	var/checkrange = (range + skill) //+1 range per mining skill up to a potential of 7.
	for(var/turf/closed/mineral/M in view(checkrange, get_turf(user)))

		if(istype(M, /turf/closed/mineral/rogue/bedrock))
			found_ore(get_turf(M), user.client, "purplesparkles")
			continue

		var/effect = M.GetOreSightState(skill)
		var/effect = M.GetOreSightColor()
		if(effect && M.mineralType)
			found_ore(get_turf(M), user.client, effect)

	//show the miners what boulders are valuable
	for(var/obj/item/natural/rock/B in view(7, get_turf(user)))

		var/state = B.GetOreSightState()
		var/effect = M.GetOreSightColor()
		if(state)
			found_ore(get_turf(B), user.client, state, color)

/proc/found_ore(atom/A, client/C, state, color)
	if(!A || !C || !state)
		return
	var/image/I = image(icon = 'icons/effects/effects.dmi', loc = A, icon_state = state, layer = 18)
	I.layer = 18
	I.plane = 18
	I.color = color
	if(!I)
		return
	I.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	flick_overlay(I, list(C), 30)
