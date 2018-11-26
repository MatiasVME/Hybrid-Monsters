extends Node2D

onready var hud = get_parent()

func update():
	$VBox/Scroll/VBox/Strength/Num.text = str(DataManager.stats[Main.current_player].get_stat_value("Strength"))
	$VBox/Scroll/VBox/Luck/Num.text = str(DataManager.stats[Main.current_player].get_stat_value("Luck"))
	$VBox/Scroll/VBox/Vitality/Num.text = str(DataManager.stats[Main.current_player].get_stat_value("Vitality"))
	
	$VBox/Points.text = str("Points: ", DataManager.stats[Main.current_player].get_points())
	
	if DataManager.stats[Main.current_player].get_points() > 0:
		hud.available_attributes()
	else:
		hud.available_attributes()
	
	attribute_button_enabler("Strength")
	attribute_button_enabler("Luck")
	attribute_button_enabler("Vitality")

func attribute_button_enabler(stat_name):
	if AttributesManager.can_add_points_to_stat(stat_name):
		get_node(str("VBox/Scroll/VBox/", stat_name,"/AddStat")).disabled = false
	else:
		get_node(str("VBox/Scroll/VBox/", stat_name,"/AddStat")).disabled = true
	
func _on_AddStat_Strength_pressed():
	AttributesManager.add_strength()
	update()

func _on_AddStat_Luck_pressed():
	AttributesManager.add_luck()
	update()

func _on_AddStat_Vitality_pressed():
	AttributesManager.add_vitality()
	update()
	hud.get_node("Status").update_hp_progress()
