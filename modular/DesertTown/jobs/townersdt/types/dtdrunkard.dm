/datum/advclass/dtdrunkard
	name = "Gambler"
	tutorial = "You are a gambler. Everyone in your life has given up on you, and the stress of losing it all over and over has taken its toll on your body. All you have left to your name are some cards, dice and whatever is in this bottle. At least you're still in Baotha's good graces, whether you reciprocate such feelings or not..."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/dtdrunkard
	traits_applied = list(TRAIT_HOMESTEAD_EXPERT)
	category_tags = list(CTAG_DTTOWNER)
	subclass_stats = list(
		STATKEY_LCK = 2,
		STATKEY_CON = 1,
		STATKEY_STR = 1,
	)
	subclass_skills = list(
		/datum/skill/misc/stealing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_APPRENTICE, //Climbing into windows to steal drugs or booze.
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
	)

/datum/outfit/job/roguetown/adventurer/dtdrunkard/pre_equip(mob/living/carbon/human/H)
	..()
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/open/random
	head = /obj/item/clothing/head/roguetown/turban/fancypurple
	pants = /obj/item/clothing/under/roguetown/sirwal/fancy/random
	shoes = /obj/item/clothing/shoes/roguetown/shalal
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/clothing/mask/cigarette/rollie/cannabis
	beltl = /obj/item/flint
	backpack_contents = list(
						/obj/item/storage/pill_bottle/dice = 1,
						/obj/item/storage/pill_bottle/dice/farkle = 1,
						/obj/item/reagent_containers/glass/cup = 1,
						/obj/item/toy/cards/deck = 1,
						/obj/item/reagent_containers/glass/bottle/rogue/wine = 1,
						/obj/item/flashlight/flare/torch = 1,
						)
	ADD_TRAIT(H, TRAIT_CRACKHEAD, TRAIT_GENERIC)
