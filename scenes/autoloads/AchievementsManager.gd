extends Node

func _ready():
	create_all_achievements()

func create_all_achievements():
	$HookAchievements.create_achievement(
		"Wood Age",
		"Get a wooden sword, enemies who have swords sometimes drop it.",
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