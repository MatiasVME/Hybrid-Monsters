extends Node

enum Achievements {
	WOOD_AGE,
	IRON_AGE,
	PROBLEMS_WITH_DRINGKING,
	IMPROVE_YOUR_OUTFIT
}

func _ready():
	create_all_achievements()

func complete_achievement_if_can(achievement_enum):
	var achievement_str

	match achievement_enum:
		Achievements.WOOD_AGE:
			achievement_str = "Wood Age"
		Achievements.IRON_AGE:
			achievement_str = "Iron Age"
		Achievements.PROBLEMS_WITH_DRINGKING:
			achievement_str = "Problems with drinking"
		Achievements.IMPROVE_YOUR_OUTFIT:
			achievement_str = "Improve your outfit"
	
	if not $HookAchievements.is_achievement_completed(achievement_str):
		$HookAchievements.complete_achievement(achievement_str)

func create_all_achievements():
	$HookAchievements.create_achievement(
		"Wood Age",
		"Get a wooden sword, enemies who have swords sometimes drop it.",
		null,
		"res://scenes/achievements/achievements_sprites/wood_age.png"
	)
	$HookAchievements.create_achievement(
		"Iron Age",
		"Get a iron sword, enemies who have iron swords sometimes drop it.",
		null,
		"res://scenes/achievements/achievements_sprites/wood_age.png"
	)
	$HookAchievements.create_achievement(
		"Problems with drinking",
		"Drink a healing potion.",
		null,
		"res://scenes/items/potions/skins/potion_health.png"
	)
	$HookAchievements.create_achievement(
		"Improve your outfit",
		"Get a armor, enemies who have armor sometimes drop it.",
		null,
		"res://scenes/achievements/achievements_sprites/wood_age.png"
	)
	
func get_achievement(achievement_name):
	return $HookAchievements.search_achievement_by_name(achievement_name)

func get_all_achievements():
	return $HookAchievements.achievements

#	$HookAchievements.create_achievement(
#		"Wood Age",
#		"Get a wooden sword, enemies who have swords sometimes drop it.",
#		null,
#		"res://scenes/achievements/achievements_sprites/wood_age.png"
#	)