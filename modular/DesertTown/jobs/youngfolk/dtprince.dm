/datum/job/roguetown/dtprince
	title = "Amir"
	f_title = "Amira"
	flag = AMIR
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_races = RACES_TOLERATED_UP //the duke isn't giving up their throne to a goblin
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT)
	advclass_cat_rolls = list(CTAG_AMIR = 20)

	tutorial = "You've never felt the gnawing of the winter, never known the bite of hunger and certainly have never known a honest day's work. You are as free as any bird in the sky, and you may revel in your debauchery for as long as your parents remain upon the throne: But someday you'll have to grow up, and that will be the day your carelessness will cost you more than a few mammons."

	display_order = JDO_PRINCE
	give_bank_account = 30
	noble_income = 20
	min_pq = 1
	max_pq = null
	allowed_maps = list("Desert Town")
	round_contrib_points = 3
	social_rank = SOCIAL_RANK_ROYAL
	cmode_music = 'sound/music/combat_noble.ogg'
	job_traits = list(TRAIT_NOBLE)
	job_subclasses = list(
		/datum/advclass/amir/dtdaring,
		/datum/advclass/amir/dtbookworm,
		/datum/advclass/amir/dtaristocrat,
		/datum/advclass/amir/dtinbred,
		/datum/advclass/amir/dtscamp
	)

// /datum/outfit/job/roguetown/heir/pre_equip(mob/living/carbon/human/H)
// 	..()
// 	H.verbs |= /mob/living/carbon/human/proc/declarechampion

/datum/advclass/amir/dtdaring
	name = "Daring Twit"
	tutorial = "You're a somebody, someone important. It only makes sense you want to make a name for yourself, to gain your own glory so people see how great you really are beyond your bloodline. Plus, if you're beloved by the people for your exploits you'll be chosen! Probably. Shame you're as useful and talented as a squire, despite your delusions to the contrary."
	outfit = /datum/outfit/job/roguetown/amir/daring
	category_tags = list(CTAG_AMIR)
	subclass_stats = list(
		STATKEY_STR = 1,
		STATKEY_PER = 1,
		STATKEY_CON = 1,
		STATKEY_SPD = 1,
		STATKEY_LCK = 1,
	)
	subclass_skills = list(
		/datum/skill/combat/maces = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/bows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/crossbows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/swords = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/riding = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/amir/daring/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/circlet
	l_hand = /obj/item/rogueweapon/sword/sabre
	beltr = /obj/item/rogueweapon/scabbard/sword
	beltl = /obj/item/storage/keyring/heir
	cloak = /obj/item/clothing/cloak/raincloak/amir
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	backr = /obj/item/storage/backpack/rogue/satchel
	shoes = /obj/item/clothing/shoes/roguetown/sandals
	id = /obj/item/clothing/ring/aalloy
	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/rogue/berrypoison = 1,
		/obj/item/reagent_containers/glass/bottle/rogue/strongstampoison = 1,
		/obj/item/reagent_containers/glass/mortar = 1,
		/obj/item/pestle = 1)
	if(should_wear_masc_clothes(H))
		head = /obj/item/clothing/head/roguetown/sultan/amir
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		belt = /obj/item/storage/belt/rogue/leather/cloth/sash/yellow
		pants = /obj/item/clothing/under/roguetown/sirwal/fancy/red
		backpack_contents = list(/obj/item/clothing/head/roguetown/circlet)
	if(should_wear_femme_clothes(H))
		pants = /obj/item/clothing/under/roguetown/thong
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/amiradress
		mask = /obj/item/clothing/mask/rogue/exoticsilkmask/red
		belt = /obj/item/storage/belt/rogue/leather/exoticsilkbelt/skirtred
		head = /obj/item/clothing/head/roguetown/circlet
		backpack_contents = list(/obj/item/clothing/suit/roguetown/shirt/exoticsilkbra/red)

/datum/advclass/amir/dtbookworm
	name = "Introverted Bookworm"
	tutorial = "Despite your standing, sociability is not your strong suit, and you have kept mostly to yourself and your books. This hardly makes you a favourite among the lords and ladies of the court, and an exit from your room is often met with amusement from nobility and servants alike. But maybe... just maybe, some of your reading interests may be bearing fruit."
	outfit = /datum/outfit/job/roguetown/amir/bookworm
	traits_applied = list(TRAIT_ARCYNE_T1, TRAIT_MAGEARMOR)
	category_tags = list(CTAG_AMIR)
	subclass_stats = list(
		STATKEY_STR = -1,
		STATKEY_INT = 2,
		STATKEY_SPD = 1,
		STATKEY_CON = -1,
		STATKEY_LCK = 1,
	)
	subclass_spellpoints = 9
	subclass_skills = list(
		/datum/skill/misc/reading = SKILL_LEVEL_MASTER,
		/datum/skill/magic/arcane = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/alchemy = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_NOVICE,
	)

/datum/outfit/job/roguetown/amir/bookworm/pre_equip(mob/living/carbon/human/H)
	..()
	if(should_wear_masc_clothes(H))
		pants = /obj/item/clothing/under/roguetown/tights/random
		armor = /obj/item/clothing/suit/roguetown/armor/longcoat
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/royal/prince
	if(should_wear_femme_clothes(H))
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/royal/princess
	head = /obj/item/clothing/head/roguetown/circlet
	belt = /obj/item/storage/belt/rogue/leather/cloth/lady
	beltr = /obj/item/storage/keyring/heir
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel/special
	backr = /obj/item/storage/backpack/rogue/satchel
	mask = /obj/item/clothing/mask/rogue/spectacles
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	cloak = /obj/item/clothing/cloak/raincloak/amir
	shoes = /obj/item/clothing/shoes/roguetown/sandals

/datum/advclass/amir/dtaristocrat
	name = "Sheltered Aristocrat"
	tutorial = "Life has been kind to you; you've an entire keep at your disposal, servants to wait on you, and a whole retinue of guards to guard you. You've nothing to prove; just live the good life and you'll be a lord someday, too. A lack of ambition translates into a lacking skillset beyond schooling, though, and your breaks from boredom consist of being a damsel or court gossip."
	outfit = /datum/outfit/job/roguetown/amir/aristocrat
	traits_applied = list(TRAIT_SEEPRICES_SHITTY, TRAIT_GOODLOVER)
	category_tags = list(CTAG_AMIR)
	subclass_stats = list(
		STATKEY_PER = 2,
		STATKEY_STR = -1,
		STATKEY_INT = 2,
		STATKEY_LCK = 1,
		STATKEY_SPD = 1
	)
	subclass_skills = list(
		/datum/skill/combat/bows = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/crossbows = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/knives = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/riding = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/sewing = SKILL_LEVEL_JOURNEYMAN,
	)

/datum/outfit/job/roguetown/amir/aristocrat/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/circlet
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/keyring/heir
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	backr = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/clothing/ring/signet
	cloak = /obj/item/clothing/cloak/raincloak/amir
	shoes = /obj/item/clothing/shoes/roguetown/sandals
	if(should_wear_masc_clothes(H))
		head = /obj/item/clothing/head/roguetown/sultan/amir
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		belt = /obj/item/storage/belt/rogue/leather/cloth/sash/yellow
		pants = /obj/item/clothing/under/roguetown/sirwal/fancy/red
		backpack_contents = list(/obj/item/clothing/head/roguetown/circlet)
	if(should_wear_femme_clothes(H))
		pants = /obj/item/clothing/under/roguetown/thong
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/amiradress
		mask = /obj/item/clothing/mask/rogue/exoticsilkmask/red
		belt = /obj/item/storage/belt/rogue/leather/exoticsilkbelt/skirtred
		head = /obj/item/clothing/head/roguetown/circlet
		backpack_contents = list(/obj/item/clothing/suit/roguetown/shirt/exoticsilkbra/red)

/datum/advclass/amir/dtinbred
	name = "Inbred wastrel"
	tutorial = "Your bloodline ensures Psydon smiles upon you by divine right, the blessing of nobility... until you were born, anyway. You are a child forsaken, and even though your body boils as you go about your day, your spine creaks, and your drooling form needs to be waited on tirelessly you are still considered more important then the peasant that keeps the town fed and warm. Remind them of that fact when your lungs are particularly pus free."
	outfit = /datum/outfit/job/roguetown/amir/inbred
	traits_applied = list(TRAIT_CRITICAL_WEAKNESS, TRAIT_NORUN, TRAIT_GOODLOVER)
	category_tags = list(CTAG_AMIR)
	//They already can't run, no need to do speed and torture their move speed.
	subclass_stats = list(
		STATKEY_STR = -2,
		STATKEY_PER = -2,
		STATKEY_INT = -2,
		STATKEY_CON = -2,
		STATKEY_WIL = -2,
		STATKEY_LCK = -2
	)
	subclass_skills = list(
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/riding = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/sewing = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/alchemy = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/amir/inbred/pre_equip(mob/living/carbon/human/H)
	..()
	beltl = /obj/item/storage/keyring/heir
	cloak = /obj/item/clothing/cloak/raincloak/amir
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	backr = /obj/item/storage/backpack/rogue/satchel
	shoes = /obj/item/clothing/shoes/roguetown/sandals
	id = /obj/item/clothing/ring/aalloy
	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/rogue/berrypoison = 1,
		/obj/item/reagent_containers/glass/bottle/rogue/strongstampoison = 1,
		/obj/item/reagent_containers/glass/mortar = 1,
		/obj/item/pestle = 1)
	if(should_wear_masc_clothes(H))
		head = /obj/item/clothing/head/roguetown/sultan/amir
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		belt = /obj/item/storage/belt/rogue/leather/cloth/sash/yellow
		pants = /obj/item/clothing/under/roguetown/sirwal/fancy/red
		backpack_contents = list(/obj/item/clothing/head/roguetown/circlet)
	if(should_wear_femme_clothes(H))
		pants = /obj/item/clothing/under/roguetown/thong
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/amiradress
		mask = /obj/item/clothing/mask/rogue/exoticsilkmask/red
		belt = /obj/item/storage/belt/rogue/leather/exoticsilkbelt/skirtred
		head = /obj/item/clothing/head/roguetown/circlet
		backpack_contents = list(/obj/item/clothing/suit/roguetown/shirt/exoticsilkbra/red)


/datum/advclass/amir/dtscamp
	name = "Nettlesome Scamp"
	tutorial = "The stories told to you by your bedside of valiant rogues and thieves with hearts of gold saving the worlds. The misunderstood hero. The clammor of Knights, the dull books of the arcyne and the wise never interested you. So you donned the cloak, and with your plump figure learned the arts of stealth. Surely the populace will be forgiving of your antics."
	outfit = /datum/outfit/job/roguetown/amir/scamp
	traits_applied = list(TRAIT_SEEPRICES_SHITTY)
	category_tags = list(CTAG_AMIR)
	//Not standard weighted. Not intended to be considering the stat ceilings. -F
	subclass_stats = list(
	STATKEY_STR = -3,
	STATKEY_CON = -3,
	STATKEY_SPD = 4,
	STATKEY_PER = 2,
	STATKEY_INT = 2,
	STATKEY_WIL = 1,
	STATKEY_LCK = 1,
	)
	subclass_skills = list(
		/datum/skill/misc/sneaking = SKILL_LEVEL_MASTER,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/stealing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/lockpicking = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/slings = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/alchemy = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/riding = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_APPRENTICE,
	)
	adv_stat_ceiling = list(STAT_STRENGTH = 8, STAT_CONSTITUTION = 8, STAT_SPEED = 15)	//don't get caught

/datum/outfit/job/roguetown/amir/scamp/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/circlet
	mask = /obj/item/clothing/head/roguetown/roguehood/black
	neck = /obj/item/storage/keyring/heir
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/quiver/sling/iron
	beltr = /obj/item/gun/ballistic/revolver/grenadelauncher/sling
	backr = /obj/item/storage/backpack/rogue/satchel
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/shorts
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced/short
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/sailor/nightman
	cloak = /obj/item/clothing/cloak/half/shadowcloak
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/rich = 1,
		/obj/item/lockpickring/mundane = 1)


// /datum/status_effect/buff/champion
// 	alert_type = /atom/movable/screen/alert/status_effect/buff/champion
// 	var/mob/living/carbon/ward = null
// 	effectedstats = list(STATKEY_CON = 1, STATKEY_WIL = 1)
// 	duration = -1

// /atom/movable/screen/alert/status_effect/buff/champion
// 	name = "Champion"
// 	desc = "I am a Chosen by a Heir!"
// 	icon_state = "buff"


// /datum/status_effect/buff/champion/on_creation()
// 	spawn(5) // sob doesnt work without this??
// 		examine_text = "<font color='yellow'>SUBJECTPRONOUN is the Champion Of [owner.mind.ward.real_name]!"
// 	return ..()

// /datum/status_effect/buff/champion/tick()
// 	for (var/mob/living/carbon/H in view(5, owner))
// 		if(H == ward)
// 			if (!owner.has_stress_event(/datum/stressevent/champion))
// 				owner.add_stress(/datum/stressevent/champion)

// /datum/status_effect/buff/champion/on_remove()
// 	ward.add_stress(/datum/stressevent/lostchampion)
// 	owner.mind.ward = null
// 	owner.remove_status_effect(/datum/status_effect/buff/champion)
// 	if(ward && ward.mind)
// 		ward.mind.champion = null
// 		ward.remove_status_effect(/datum/status_effect/buff/ward)


// /datum/status_effect/buff/ward
// 	alert_type = /atom/movable/screen/alert/status_effect/buff/ward
// 	var/mob/living/carbon/champion = null
// 	effectedstats = list(STATKEY_LCK = 1, STATKEY_WIL = 1)
// 	duration = -1

// /atom/movable/screen/alert/status_effect/buff/ward
// 	name = "Ward"
// 	desc = "I have declared a champion."
// 	icon_state = "buff"

// /datum/status_effect/buff/ward/tick()
// 	for (var/mob/living/carbon/H in view(5, owner))
// 		if(H == champion)
// 			if(!owner.has_stress_event(/datum/stressevent/ward))
// 				owner.add_stress(/datum/stressevent/ward)

// /datum/status_effect/buff/ward/on_remove()
// 	champion.add_stress(/datum/stressevent/lostward)
// 	owner.mind.champion = null
// 	owner.remove_status_effect(/datum/status_effect/buff/ward)
// 	if(champion && champion.mind)
// 		champion.mind.ward = null
// 		champion.remove_status_effect(/datum/status_effect/buff/champion)
