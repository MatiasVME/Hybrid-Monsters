extends Node

enum Achievements {
	WOOD_AGE,
	IRON_AGE,
	DIAMOND_AGE,
	RUBY_AGE,
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
		Achievements.DIAMOND_AGE:
			achievement_str = "Diamond Age"
		Achievements.RUBY_AGE:
			achievement_str = "Ruby Age"
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
		"res://scenes/achievements/achievements_sprites/iron_age.png"
	)
	$HookAchievements.create_achievement(
		"Diamond Age",
		"Get a diamond sword, enemies who have diamond swords sometimes drop it.",
		null,
		"res://scenes/achievements/achievements_sprites/diamond_age.png"
	)
	$HookAchievements.create_achievement(
		"Ruby Age",
		"Get a ruby sword, enemies who have ruby swords sometimes drop it.",
		null,
		"res://scenes/achievements/achievements_sprites/ruby_age.png"
	)
	$HookAchievements.create_achievement(
		"Problems with drinking",
		"Drink a healing potion.",
		null,
		"res://scenes/achievements/achievements_sprites/problems_with_drinking.png"
	)
	$HookAchievements.create_achievement(
		"Improve your outfit",
		"Get a armor, enemies who have armor sometimes drop it.",
		null,
		"res://scenes/achievements/achievements_sprites/improve_your_outfit.png"
	)
	
func get_achievement(achievement_name):
	return $HookAchievements.search_achievement_by_name(achievement_name)

func get_all_achievements():
	return $HookAchievements.achievements