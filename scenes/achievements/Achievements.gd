extends Node2D

func _ready():
	var achievements = AchievementsManager.get_all_achievements()
	
	for i in achievements.size():
		add_achievement(achievements[i])
		print("Hola")
	
func add_achievement(achievement):
	var slot = load("res://scenes/achievements/Slot.tscn").instance()
	slot.add_achievement(achievement)
	$HBox/Slots/Grid.add_child(slot)
	