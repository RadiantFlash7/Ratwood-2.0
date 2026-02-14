/datum/job/roguetown/mamluk
	title = "Mamluk"
	flag = MAMLUK
	department_flag = GARRISON
	faction = "Station"
	total_positions = 8
	spawn_positions = 8

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = ACCEPTED_RACES
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	job_traits = list(TRAIT_GUARDSMAN, TRAIT_STEELHEARTED)
	tutorial = "You are a member of the Sultans Retinue. Ensure the safety of the Sultan and their subjects, defend the powers that be from the horrors of the outside world, and keep the Sultanate alive."
	display_order = JDO_CASTLEGUARD
	whitelist_req = TRUE

	outfit = /datum/outfit/job/roguetown/mamluk
	advclass_cat_rolls = list(CTAG_MAMLUK = 20)

	give_bank_account = 22
	min_pq = 3
	max_pq = null
	round_contrib_points = 2
	allowed_maps = list("Desert Town")
	social_rank = SOCIAL_RANK_YEOMAN
	cmode_music = 'sound/music/combat_ManAtArms.ogg'
	job_subclasses = list(
		/datum/advclass/mamluk/footman,
		/datum/advclass/mamluk/zephyr,
	)

/datum/outfit/job/roguetown/mamluk
	job_bitflag = BITFLAG_GARRISON

/datum/outfit/job/roguetown/mamluk
	shoes = /obj/item/clothing/shoes/roguetown/shalal
	beltl = /obj/item/rogueweapon/whip
	belt = /obj/item/storage/belt/rogue/leather
	backr = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/scomstone/bad/garrison
