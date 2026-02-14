/datum/advclass/dtminstrel
	name = "Minstrel"
	tutorial = "The people love music, they crave entertainment as much as they crave food and luckily for them \
	you have always been there to provide such songs to soothe sore ears."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/dtminstrel
	subclass_social_rank = SOCIAL_RANK_PEASANT
	category_tags = list(CTAG_DTTOWNER)
	traits_applied = list(TRAIT_EMPATH, TRAIT_GOODLOVER, TRAIT_HOMESTEAD_EXPERT)
	subclass_stats = list(
		STATKEY_SPD = 2,
		STATKEY_INT = 2,
		STATKEY_PER = 2,
		STATKEY_LCK = 2
	)
	subclass_skills = list(
		/datum/skill/misc/music = SKILL_LEVEL_MASTER,
		/datum/skill/misc/reading = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/swords = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/stealing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/lockpicking = SKILL_LEVEL_JOURNEYMAN,
	)

/datum/outfit/job/roguetown/adventurer/dtminstrel/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/open/random
	head = /obj/item/clothing/head/roguetown/turban/fancypurple
	pants = /obj/item/clothing/under/roguetown/sirwal/fancy/random
	shoes = /obj/item/clothing/shoes/roguetown/shalal
	belt = /obj/item/storage/belt/rogue/leather/cloth/sash/random
	beltr = /obj/item/rogueweapon/huntingknife/idagger
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
						/obj/item/rogue/instrument/shamisen = 1,
						/obj/item/rogue/instrument/flute = 1,
						/obj/item/rogue/instrument/drum = 1,
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/rogueweapon/scabbard/sheath = 1,
						/obj/item/natural/feather = 1, /obj/item/paper/scroll = 1,
						/obj/item/lockpick = 1,
						/obj/item/rogueweapon/scabbard/sheath = 1
						)
	var/datum/inspiration/I = new /datum/inspiration(H)
	I.grant_inspiration(H, bard_tier = BARD_T3)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mockery)
		var/weapons = list("Accordion","Drum","Flute","Guitar","Harp","Hurdy-Gurdy","Lute","Psyaltery","Shamisen","Trumpet","Viola","Vocal Talisman")
		var/weapon_choice = tgui_input_list(H, "Choose your instrument.", "TAKE UP ARMS", weapons)
		H.set_blindness(0)
		switch(weapon_choice)
			if("Accordion")
				backr = /obj/item/rogue/instrument/accord
			if("Drum")
				backr = /obj/item/rogue/instrument/drum
			if("Flute")
				backr = /obj/item/rogue/instrument/flute
			if("Guitar")
				backr = /obj/item/rogue/instrument/guitar
			if("Harp")
				backr = /obj/item/rogue/instrument/harp
			if("Hurdy-Gurdy")
				backr = /obj/item/rogue/instrument/hurdygurdy
			if("Lute")
				backr = /obj/item/rogue/instrument/lute
			if("Psyaltery")
				backr = /obj/item/rogue/instrument/psyaltery
			if("Shamisen")
				backr = /obj/item/rogue/instrument/shamisen
			if("Trumpet")
				backr = /obj/item/rogue/instrument/trumpet
			if("Viola")
				backr = /obj/item/rogue/instrument/viola
			if("Vocal Talisman")
				backr = /obj/item/rogue/instrument/vocals
