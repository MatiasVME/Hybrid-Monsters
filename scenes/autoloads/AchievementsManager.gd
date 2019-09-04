extends Node

enum Achievements {
	WOOD_AGE,
	IRON_AGE,
	DIAMOND_AGE,
	RUBY_AGE,
	PROBLEMS_WITH_DRINGKING,
	IMPROVE_YOUR_OUTFIT,
	LVL3,
	LVL5,
	LVL10,
	LVL15,
	ASSASSIN10,
	ASSASSIN25,
	ASSASSIN50,
	ASSASSIN75,
	ASSASSIN100,
	ASSASSIN150,
	ASSASSIN250,
	ASSASSIN500
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
		Achievements.LVL3:
			achievement_str = "OMG!! Level 3!"
		Achievements.LVL5:
			achievement_str = "WTF!! Level 5!"
		Achievements.LVL10:
			achievement_str = "Cool!! Level 10!"
		Achievements.LVL15:
			achievement_str = "O_o! Level 15!"
		Achievements.ASSASSIN10:
			achievement_str = "10 Enemies Killed!!"
		Achievements.ASSASSIN25:
			achievement_str = "25 Enemies Killed!!"
		Achievements.ASSASSIN50:
			achievement_str = "50 Enemies Killed!!"
		Achievements.ASSASSIN75:
			achievement_str = "75 Enemies Killed!!"
		Achievements.ASSASSIN100:
			achievement_str = "100 Enemies Killed!!"
		Achievements.ASSASSIN150:
			achievement_str = "150 Enemies Killed!!"
		Achievements.ASSASSIN250:
			achievement_str = "250 Enemies Killed!!"
		Achievements.ASSASSIN500:
			achievement_str = "500 Enemies Killed!!"
	
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
	$HookAchievements.create_achievement(
		"OMG!! Level 3!",
		"Reach level 3",
		null,
		"res://scenes/achievements/achievements_sprites/level3.png"
	)
	$HookAchievements.create_achievement(
		"WTF!! Level 5!",
		"Reach level 5",
		null,
		"res://scenes/achievements/achievements_sprites/level5.png"
	)
	$HookAchievements.create_achievement(
		"OMG!! Level 3!",
		"Reach level 10",
		null,
		"res://scenes/achievements/achievements_sprites/level10.png"
	)
	$HookAchievements.create_achievement(
		"O_o! Level 15!",
		"Reach level 15",
		null,
		"res://scenes/achievements/achievements_sprites/level15.png"
	)
	$HookAchievements.create_achievement(
		"10 Enemies Killed!!",
		"Kill 10 Enemies",
		null,
		"res://scenes/achievements/achievements_sprites/Assassin10.png"
	)
	$HookAchievements.create_achievement(
		"25 Enemies Killed!!",
		"Kill 25 Enemies",
		null,
		"res://scenes/achievements/achievements_sprites/Assassin25.png"
	)
	$HookAchievements.create_achievement(
		"50 Enemies Killed!!",
		"Kill 50 Enemies",
		null,
		"res://scenes/achievements/achievements_sprites/Assassin50.png"
	)
	$HookAchievements.create_achievement(
		"75 Enemies Killed!!",
		"Kill 75 Enemies",
		null,
		"res://scenes/achievements/achievements_sprites/Assassin75.png"
	)
	$HookAchievements.create_achievement(
		"100 Enemies Killed!!",
		"Kill 100 Enemies",
		null,
		"res://scenes/achievements/achievements_sprites/Assassin100.png"
	)
	$HookAchievements.create_achievement(
		"155 Enemies Killed!!",
		"Kill 150 Enemies",
		null,
		"res://scenes/achievements/achievements_sprites/Assassin150.png"
	)
	$HookAchievements.create_achievement(
		"250 Enemies Killed!!",
		"Kill 250 Enemies",
		null,
		"res://scenes/achievements/achievements_sprites/Assassin250.png"
	)
	$HookAchievements.create_achievement(
		"500 Enemies Killed!!",
		"Kill 500 Enemies",
		null,
		"res://scenes/achievements/achievements_sprites/Assassin500.png"
	)
	
func get_achievement(achievement_name):
	return $HookAchievements.search_achievement_by_name(achievement_name)

func get_all_achievements():
	return $HookAchievements.achievements