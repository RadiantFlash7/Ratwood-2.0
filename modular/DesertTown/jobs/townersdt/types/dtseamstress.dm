/datum/advclass/dtseamstress
	name = "Seamster"
	tutorial = "You know your trade by the passage of a needle through cloth and leather alike. Mend and sew garments for the townsfolk - Coats, pants, hats, hoods, and so much more. So what if you overcharge? You're the reason everyone looks good in the first place."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/dtseamstress
	subclass_social_rank = SOCIAL_RANK_YEOMAN
	traits_applied = list(TRAIT_SEWING_EXPERT, TRAIT_SELF_SUSTENANCE, TRAIT_DYES)
	category_tags = list(CTAG_DTTOWNER)
	subclass_stats = list(
		STATKEY_SPD = 2,
		STATKEY_INT = 3,
		STATKEY_PER = 2,
		STATKEY_STR = -1
	)
	subclass_skills = list(
		/datum/skill/craft/sewing = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/crafting = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/medicine = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/labor/farming = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/tanning = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/stealing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/sneaking = SKILL_LEVEL_JOURNEYMAN,//heeheehoohoo
	)

/datum/outfit/job/roguetown/adventurer/dtseamstress/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/raincloak/furcloak
	shirt = /obj/item/clothing/suit/roguetown/shirt/dress/thawb/gold
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/bisht/purple
	head = /obj/item/clothing/head/roguetown/turban/fancypurple
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather/cloth/sash/random
	beltl = /obj/item/needle
	beltr = /obj/item/rogueweapon/huntingknife/scissors
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
						/obj/item/natural/cloth = 2,
						/obj/item/natural/bundle/fibers/full = 1,
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/needle/thorn = 1,
						/obj/item/recipe_book/sewing = 1,
						/obj/item/book/rogue/swatchbook = 1,
						/obj/item/recipe_book/leatherworking = 1
						)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/fittedclothing) 
