/datum/job/roguetown/dtvillager
	title = "Villager"
	flag = VILLAGER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 75
	spawn_positions = 75
	allowed_races = ACCEPTED_RACES
	tutorial = "You've lived in this shithole for effectively all your life. You are not an explorer, nor exactly a warrior in many cases. You're just some average poor bastard who thinks they'll be something someday. Respect the nobles and yeomen alike for they are your superiors - should you find yourself in trouble your Elder is your best hope."
	advclass_cat_rolls = list(CTAG_DTTOWNER = 20)
	outfit = null
	outfit_female = null
	bypass_lastclass = TRUE
	bypass_jobban = FALSE
	display_order = JDO_VILLAGER
	give_bank_account = TRUE
	min_pq = -15
	max_pq = null
	round_contrib_points = 2
	wanderer_examine = FALSE
	advjob_examine = TRUE
	always_show_on_latechoices = TRUE
	same_job_respawn_delay = 0
	cmode_music = 'sound/music/cmode/towner/combat_towner.ogg'
	social_rank = SOCIAL_RANK_PEASANT
	allowed_maps = list("Desert Town")
	job_subclasses = list(
		/datum/advclass/dtbarbersurgeon,
		/datum/advclass/dtblacksmith,
		/datum/advclass/dtcheesemaker,
		/datum/advclass/dtdrunkard,
		/datum/advclass/dtfisher,
		/datum/advclass/dthunter,
		/datum/advclass/dthunter/spear,
		/datum/advclass/dtminer,
		/datum/advclass/dtminstrel,
		/datum/advclass/dtpeasant,
		/datum/advclass/dtpotter,
		/datum/advclass/dtseamstress,
		/datum/advclass/thug,
		/datum/advclass/witch,
		/datum/advclass/dtwoodworker
	)

/*
/datum/job/roguetown/adventurer/villager/New()
	. = ..()
	for(var/X in GLOB.peasant_positions)
		peopleiknow += X
		peopleknowme += X
	for(var/X in GLOB.yeoman_positions)
		peopleiknow += X
	for(var/X in GLOB.church_positions)
		peopleiknow += X
	for(var/X in GLOB.garrison_positions)
		peopleiknow += X
	for(var/X in GLOB.noble_positions)
		peopleiknow += X*/

//We don't need to reskin the foreigners - they're foreign!
// /datum/job/roguetown/nomad
// 	title = "Nomad"
// 	flag = NOMAD
// 	department_flag = PEASANTS
// 	faction = "Station"
// 	total_positions = 40
// 	spawn_positions = 40 //brings back round-start spawn of pilgrims!!!
// 	allowed_races = RACES_ALL_KINDS
// 	allowed_maps = list("Desert Town")
// 	tutorial = "Fleeing misfortune you head your way towards Al-Ashur. You're not a soldier or an explorer, but a humble migrant trying to look for a better life, if you get to survive the trip that is."

// 	outfit = null
// 	outfit_female = null
// 	bypass_lastclass = TRUE
// 	bypass_jobban = FALSE

// 	job_subclasses = list(
// 		/datum/advclass/dtbarbersurgeon,
// 		/datum/advclass/dtblacksmith,
// 		/datum/advclass/dtcheesemaker,
// 		/datum/advclass/dtdrunkard,
// 		/datum/advclass/dtfisher,
// 		/datum/advclass/dthunter,
// 		/datum/advclass/dthunter/spear,
// 		/datum/advclass/dtminer,
// 		/datum/advclass/dtminstrel,
// 		/datum/advclass/dtpeasant,
// 		/datum/advclass/dtpotter,
// 		/datum/advclass/dtseamstress,
// 		/datum/advclass/thug,
// 		/datum/advclass/witch,
// 		/datum/advclass/dtwoodworker
// 	)


// 	advclass_cat_rolls = list(CTAG_NOMAD = 20)
// 	PQ_boost_divider = 10

// 	announce_latejoin = FALSE
// 	display_order = JDO_PILGRIM
// 	min_pq = -20
// 	max_pq = null
// 	wanderer_examine = TRUE
// 	advjob_examine = TRUE
// 	always_show_on_latechoices = TRUE
// 	same_job_respawn_delay = 0
