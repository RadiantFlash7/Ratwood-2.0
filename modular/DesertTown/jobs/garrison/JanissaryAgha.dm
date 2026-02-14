/datum/job/roguetown/JanissaryAgha
	title = "Janissary Agha"
	flag = SERGEANT
	department_flag = GARRISON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_maps = list("Desert Town")
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = ACCEPTED_RACES
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "An experienced soldier of the Sultan's Janissary Corp you have been tasked with overseeing the newly constructed border. \
				You report to the Royal Family and their Councillors, \
				and your job is to keep the younger Janissaries in line and to ensure the routes to the city remain safe.\
				The Border must not fall."
	display_order = JDO_SERGEANT
	whitelist_req = TRUE
	round_contrib_points = 3
	social_rank = SOCIAL_RANK_YEOMAN

	outfit = /datum/outfit/job/roguetown/JanissaryAgha
	advclass_cat_rolls = list(CTAG_SERGEANT = 20)

	give_bank_account = 50
	min_pq = 6
	max_pq = null
	cmode_music = 'sound/music/combat_ManAtArms.ogg'
	job_traits = list(TRAIT_OUTDOORSMAN, TRAIT_WOODSMAN, TRAIT_SURVIVAL_EXPERT, TRAIT_STEELHEARTED, TRAIT_MEDIUMARMOR)
	job_subclasses = list(
		/datum/advclass/JanissaryAgha/JanissaryAgha
	)
/datum/outfit/job/roguetown/JanissaryAgha
	job_bitflag = BITFLAG_GARRISON

/datum/job/roguetown/JanissaryAgha/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(ishuman(L))
			if(istype(H.cloak, /obj/item/clothing/cloak/half/shadowcloak))
				var/obj/item/clothing/S = H.cloak
				var/index = findtext(H.real_name, " ")
				if(index)
					index = copytext(H.real_name, 1,index)
				if(!index)
					index = H.real_name
				S.name = "Agha Cloak ([index])"

//All skills/traits are on the loadouts. All are identical. Welcome to the stupid way we have to make sub-classes...
/datum/outfit/job/roguetown/JanissaryAgha
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/janissary
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	pants = /obj/item/clothing/under/roguetown/chainlegs/kilt
	cloak = /obj/item/clothing/cloak/half/shadowcloak
	neck = /obj/item/clothing/neck/roguetown/bevor
	shoes = /obj/item/clothing/shoes/roguetown/shalal
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	gloves = /obj/item/clothing/gloves/roguetown/plate/iron
	backr = /obj/item/storage/backpack/rogue/satchel
	head = /obj/item/clothing/head/roguetown/helmet/janissary
	id = /obj/item/scomstone/garrison

//Rare-ish anti-armor two hander sword. Kinda alternative of a bastard sword type. Could be cool.
/datum/advclass/JanissaryAgha/JanissaryAgha
	name = "Sergeant-at-Arms"
	tutorial = "An experienced soldier of the Sultan's Janissary Corp you have been tasked with overseeing the newly constructed border. \
				You report to the Royal Family and their Councillors, \
				and your job is to keep the younger Janissaries in line and to ensure the routes to the city remain safe.\
				The Border must not fall."
	outfit = /datum/outfit/job/roguetown/JanissaryAgha/JanissaryAgha

	category_tags = list(CTAG_SERGEANT)
	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_INT = 1,
		STATKEY_CON = 1,
		STATKEY_PER = 1, //Gets bow-skills, so give a SMALL tad of perception to aid in bow draw.
		STATKEY_WIL = 1,
	)
	subclass_skills = list(
		/datum/skill/combat/polearms = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/swords = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/axes = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/whipsflails = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/maces = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/shields = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/crossbows = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/bows = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/sneaking = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_MASTER,	// We are basically identical to a regular MAA, except having better athletics to help us manage our order usage better
		/datum/skill/misc/riding = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/tracking = SKILL_LEVEL_APPRENTICE,	//Decent tracking akin to Skirmisher.
	)

/datum/outfit/job/roguetown/JanissaryAgha/JanissaryAgha/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/movemovemove)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/takeaim)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/onfeet)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/hold)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/order/focustarget)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/convertrole/guard) // We'll just use Watchmen as sorta conscripts yeag?
	H.verbs |= list(/mob/living/carbon/human/proc/request_outlaw, /mob/proc/haltyell, /mob/living/carbon/human/mind/proc/setorders)
	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		/obj/item/rope/chain = 1,
		/obj/item/storage/keyring/guardsergeant = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1,
		)
	H.adjust_blindness(-3)
	if(H.mind)
		var/weapons = list("Shotel","Flail & Shield","Halberd","Sabre & Crossbow")	//Bit more unique than footsman, you are a jack-of-all-trades + slightly more 'elite'.
		var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
		H.set_blindness(0)
		switch(weapon_choice)
			if("Shotel")		
				backl = /obj/item/rogueweapon/scabbard/sword
				l_hand = /obj/item/rogueweapon/sword/long/shotel
				beltr = /obj/item/rogueweapon/mace/cudgel
			if("Whip & Shield")	
				beltr = /obj/item/rogueweapon/whip/antique
				backl = /obj/item/rogueweapon/shield/iron/zybantine
			if("Glaive")			
				r_hand = /obj/item/rogueweapon/halberd/glaive
				backl = /obj/item/rogueweapon/scabbard/gwstrap
				beltr = /obj/item/rogueweapon/mace/cudgel
			if("Sabre & Crossbow")	//Versetile skirmisher class. Considered other swords but sabre felt best without being too strong. (This one gets no cudgel, no space.)
				beltr = /obj/item/quiver/bolts
				backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
				r_hand = /obj/item/rogueweapon/sword/sabre
				l_hand = /obj/item/rogueweapon/scabbard/sword

// /obj/effect/proc_holder/spell/invoked/order
// 	name = ""
// 	range = 1
// 	associated_skill = /datum/skill/misc/athletics
// 	devotion_cost = 0
// 	chargedrain = 1
// 	chargetime = 15
// 	releasedrain = 80 // This is quite costy. Shouldn't be able to really spam them right off the cuff, combined with having to type out an order. Should prevent VERY occupied officers from ALSO ordering
// 	recharge_time = 2 MINUTES
// 	miracle = FALSE
// 	sound = 'sound/magic/inspire_02.ogg'


// /obj/effect/proc_holder/spell/invoked/order/movemovemove
// 	name = "Move! Move! Move!"
// 	desc = "Orders your underlings to move faster. +5 Speed."
// 	overlay_state = "movemovemove"

// /obj/effect/proc_holder/spell/invoked/order/movemovemove/cast(list/targets, mob/living/user)
// 	. = ..()
// 	if(isliving(targets[1]))
// 		var/mob/living/target = targets[1]
// 		var/msg = user.mind.movemovemovetext
// 		if(!msg)
// 			to_chat(user, span_alert("I must say something to give an order!"))
// 			return
// 		if(user.job == "Sergeant")
// 			if(!(target.job in list("Man at Arms", "Watchman")))
// 				to_chat(user, span_alert("I cannot order one not of my ranks!"))
// 				revert_cast()
// 				return
// 		if(user.job == "Knight Captain")
// 			if(!(target.job in list("Knight", "Squire")))
// 				to_chat(user, span_alert("I cannot order one not of my ranks!"))
// 				revert_cast()
// 				return
// 		if(target == user)
// 			to_chat(user, span_alert("I cannot order myself!"))
// 			revert_cast()
// 			return
// 		user.say("[msg]")
// 		target.apply_status_effect(/datum/status_effect/buff/order/movemovemove)
// 		return TRUE
// 	revert_cast()
// 	return FALSE

// /datum/status_effect/buff/order/movemovemove/nextmove_modifier()
// 	return 0.85

// /datum/status_effect/buff/order/movemovemove
// 	id = "movemovemove"
// 	alert_type = /atom/movable/screen/alert/status_effect/buff/order/movemovemove
// 	effectedstats = list(STATKEY_SPD = 5)
// 	duration = 1 MINUTES

// /atom/movable/screen/alert/status_effect/buff/order/movemovemove
// 	name = "Move! Move! Move!"
// 	desc = "My officer has ordered me to move quickly!"
// 	icon_state = "buff"

// /datum/status_effect/buff/order/movemovemove/on_apply()
// 	. = ..()
// 	to_chat(owner, span_blue("My officer orders me to move!"))

// /obj/effect/proc_holder/spell/invoked/order/takeaim
// 	name = "Take aim!"
// 	desc = "Orders your underlings to be more precise. +5 Perception."
// 	overlay_state = "takeaim"

// /datum/status_effect/buff/order/takeaim
// 	id = "takeaim"
// 	alert_type = /atom/movable/screen/alert/status_effect/buff/order/takeaim
// 	effectedstats = list(STATKEY_PER = 5)
// 	duration = 1 MINUTES

// /atom/movable/screen/alert/status_effect/buff/order/takeaim
// 	name = "Take aim!"
// 	desc = "My officer has ordered me to take aim!"
// 	icon_state = "buff"

// /datum/status_effect/buff/order/takeaim/on_apply()
// 	. = ..()
// 	to_chat(owner, span_blue("My officer orders me to take aim!"))

// /obj/effect/proc_holder/spell/invoked/order/takeaim/cast(list/targets, mob/living/user)
// 	. = ..()
// 	if(isliving(targets[1]))
// 		var/mob/living/target = targets[1]
// 		var/msg = user.mind.takeaimtext
// 		if(!msg)
// 			to_chat(user, span_alert("I must say something to give an order!"))
// 			return
// 		if(user.job == "Sergeant")
// 			if(!(target.job in list("Man at Arms", "Watchman")))
// 				to_chat(user, span_alert("I cannot order one not of my ranks!"))
// 				revert_cast()
// 				return
// 		if(user.job == "Knight Captain")
// 			if(!(target.job in list("Knight", "Squire")))
// 				to_chat(user, span_alert("I cannot order one not of my ranks!"))
// 				revert_cast()
// 				return
// 		if(target == user)
// 			to_chat(user, span_alert("I cannot order myself!"))
// 			revert_cast()
// 			return
// 		user.say("[msg]")
// 		target.apply_status_effect(/datum/status_effect/buff/order/takeaim)
// 		return TRUE
// 	revert_cast()
// 	return FALSE



// /obj/effect/proc_holder/spell/invoked/order/onfeet
// 	name = "On your feet!"
// 	desc = "Orders your underlings to stand up."
// 	overlay_state = "onfeet"

// /obj/effect/proc_holder/spell/invoked/order/onfeet/cast(list/targets, mob/living/user)
// 	. = ..()
// 	if(isliving(targets[1]))
// 		var/mob/living/target = targets[1]
// 		var/msg = user.mind.onfeettext
// 		if(!msg)
// 			to_chat(user, span_alert("I must say something to give an order!"))
// 			return
// 		if(user.job == "Sergeant")
// 			if(!(target.job in list("Man at Arms", "Watchman")))
// 				to_chat(user, span_alert("I cannot order one not of my ranks!"))
// 				revert_cast()
// 				return
// 		if(user.job == "Knight Captain")
// 			if(!(target.job in list("Knight", "Squire")))
// 				to_chat(user, span_alert("I cannot order one not of my ranks!"))
// 				revert_cast()
// 				return
// 		if(target == user)
// 			to_chat(user, span_alert("I cannot order myself!"))
// 			revert_cast()
// 			return
// 		user.say("[msg]")
// 		target.apply_status_effect(/datum/status_effect/buff/order/onfeet)
// 		if(!(target.mobility_flags & MOBILITY_STAND))
// 			target.SetUnconscious(0)
// 			target.SetSleeping(0)
// 			target.SetParalyzed(0)
// 			target.SetImmobilized(0)
// 			target.SetStun(0)
// 			target.SetKnockdown(0)
// 			target.set_resting(FALSE)
// 		return TRUE
// 	revert_cast()
// 	return FALSE

// /datum/status_effect/buff/order/onfeet
// 	id = "onfeet"
// 	alert_type = /atom/movable/screen/alert/status_effect/buff/order/onfeet
// 	duration = 30 SECONDS

// /atom/movable/screen/alert/status_effect/buff/order/onfeet
// 	name = "On your feet!"
// 	desc = "My officer has ordered me to my feet!"
// 	icon_state = "buff"

// /datum/status_effect/buff/order/onfeet/on_apply()
// 	. = ..()
// 	to_chat(owner, span_blue("My officer orders me to my feet!"))
// 	ADD_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)

// /datum/status_effect/buff/order/onfeet/on_remove()
// 	REMOVE_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)
// 	. = ..()


// /obj/effect/proc_holder/spell/invoked/order/hold
// 	name = "Hold!"
// 	desc = "Orders your underlings to Endure. +2 Willpower and Constitution."
// 	overlay_state = "hold"


// /obj/effect/proc_holder/spell/invoked/order/hold/cast(list/targets, mob/living/user)
// 	. = ..()
// 	if(isliving(targets[1]))
// 		var/mob/living/target = targets[1]
// 		var/msg = user.mind.holdtext
// 		if(!msg)
// 			to_chat(user, span_alert("I must say something to give an order!"))
// 			return
// 		if(user.job == "Sergeant")
// 			if(!(target.job in list("Man at Arms", "Watchman")))
// 				to_chat(user, span_alert("I cannot order one not of my ranks!"))
// 				revert_cast()
// 				return
// 		if(user.job == "Knight Captain")
// 			if(!(target.job in list("Knight", "Squire")))
// 				to_chat(user, span_alert("I cannot order one not of my ranks!"))
// 				revert_cast()
// 				return
// 		if(target == user)
// 			to_chat(user, span_alert("I cannot order myself!"))
// 			revert_cast()
// 			return
// 		user.say("[msg]")
// 		target.apply_status_effect(/datum/status_effect/buff/order/hold)
// 		return TRUE
// 	revert_cast()
// 	return FALSE


// /datum/status_effect/buff/order/hold
// 	id = "hold"
// 	alert_type = /atom/movable/screen/alert/status_effect/buff/order/hold
// 	effectedstats = list(STATKEY_WIL = 2, STATKEY_CON = 2)
// 	duration = 1 MINUTES

// /atom/movable/screen/alert/status_effect/buff/order/hold
// 	name = "Hold!"
// 	desc = "My officer has ordered me to hold!"
// 	icon_state = "buff"

// /datum/status_effect/buff/order/hold/on_apply()
// 	. = ..()
// 	to_chat(owner, span_blue("My officer orders me to hold!"))

// #define TARGET_FILTER "target_marked"

// /obj/effect/proc_holder/spell/invoked/order/focustarget
// 	name = "Focus target!"
// 	desc = "Tells your underlings to target a vulnerable spot on the enemy. Applies Crit vulnerability on enemy and gives them -2 Fortune."
// 	overlay_state = "focustarget"


// /obj/effect/proc_holder/spell/invoked/order/focustarget/cast(list/targets, mob/living/user)
// 	. = ..()
// 	if(isliving(targets[1]))
// 		var/mob/living/target = targets[1]
// 		var/msg = user.mind.focustargettext
// 		if(!msg)
// 			to_chat(user, span_alert("I must say something to give an order!"))
// 			return
// 		if(target == user)
// 			to_chat(user, span_alert("I cannot order myself to be killed!"))
// 			return
// 		if(HAS_TRAIT(target, TRAIT_CRITICAL_WEAKNESS))
// 			to_chat(user, span_alert("They are already vulnerable!"))
// 			return
// 		user.say("[msg]")
// 		target.apply_status_effect(/datum/status_effect/debuff/order/focustarget)
// 		return TRUE
// 	revert_cast()
// 	return FALSE

// /datum/status_effect/debuff/order/focustarget
// 	id = "focustarget"
// 	alert_type = /atom/movable/screen/alert/status_effect/debuff/order/focustarget
// 	effectedstats = list(STATKEY_LCK = -2)
// 	duration = 1 MINUTES
// 	var/outline_colour = "#69050a"

// /atom/movable/screen/alert/status_effect/debuff/order/focustarget
// 	name = "Targetted"
// 	desc = "A officer has marked me for death!"
// 	icon_state = "targetted"

// /datum/status_effect/debuff/order/focustarget/on_apply()
// 	. = ..()
// 	var/filter = owner.get_filter(TARGET_FILTER)
// 	to_chat(owner, span_alert("I have been marked for death by a officer!"))
// 	ADD_TRAIT(owner, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
// 	if (!filter)
// 		owner.add_filter(TARGET_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 200, "size" = 1))
// 	return TRUE

// /datum/status_effect/debuff/order/focustarget/on_remove()
// 	. = ..()
// 	REMOVE_TRAIT(owner, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
// 	owner.remove_filter(TARGET_FILTER)


// /obj/effect/proc_holder/spell/invoked/order/focustarget
// 	name = "Focus target!"
// 	overlay_state = "focustarget"


// #undef TARGET_FILTER


// /mob/living/carbon/human/mind/proc/setorders()
// 	set name = "Rehearse Orders"
// 	set category = "Voice of Command"
// 	mind.movemovemovetext = input("Send a message.", "Move! Move! Move!") as text|null
// 	if(!mind.movemovemovetext)
// 		to_chat(src, "I must rehearse something for this order...")
// 		return
// 	mind.holdtext = input("Send a message.", "Hold!") as text|null
// 	if(!mind.holdtext)
// 		to_chat(src, "I must rehearse something for this order...")
// 		return
// 	mind.takeaimtext = input("Send a message.", "Take aim!") as text|null
// 	if(!mind.takeaimtext)
// 		to_chat(src, "I must rehearse something for this order...")
// 		return
// 	mind.onfeettext = input("Send a message.", "On your feet!") as text|null
// 	if(!mind.onfeettext)
// 		to_chat(src, "I must rehearse something for this order...")
// 		return
// 	mind.focustargettext = input("Send a message.", "Focus Target!") as text|null
// 	if(!mind.focustargettext)
// 		to_chat(src, "I must rehearse something for this order...")
// 		return
