extends Node2D

func _ready():
	add_all_achievement_slots()

func add_all_achievement_slots():
	for child in $HBox/Slots/Grid.get_children():
		$HBox/Slots/Grid.remove_child(child)
	
	var achievements = AchievementsManager.get_all_achievements()
	
	for i in achievements.size():
		add_achievement(achievements[i])
		
	for achievement_gui in get_tree().get_nodes_in_group("AchievementGUI"):
		achievement_gui.connect("toggled", self, "_on_achievement_toggled", [achievement_gui])

func update():
	for achievement_gui in get_tree().get_nodes_in_group("AchievementGUI"):
		achievement_gui.update()

func add_achievement(achievement):
	var slot = load("res://scenes/achievements/Slot.tscn").instance()
	slot.add_achievement(achievement)
	$HBox/Slots/Grid.add_child(slot)

func deselect_all_items_except(achievement_gui_except):
	for achievement_gui in get_tree().get_nodes_in_group("AchievementGUI"):
		if achievement_gui != achievement_gui_except and achievement_gui.pressed:
			achievement_gui.pressed = false

func describe_achievement(achievement):
	var desc_achievement = load("res://scenes/achievements/AchievementDesc.tscn").instance()
	desc_achievement.achievement = achievement
	desc_achievement.update()
	
	$HBox/Description/Grid.add_child(desc_achievement)
	
func remove_all_descriptions():
	for child in $HBox/Description/Grid.get_children():
		$HBox/Description/Grid.remove_child(child)

func _on_achievement_toggled(button_pressed, achievement_gui):
	remove_all_descriptions()
	
	if button_pressed:
		deselect_all_items_except(achievement_gui)
		describe_achievement(achievement_gui.achievement)
