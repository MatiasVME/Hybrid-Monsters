extends Node2D

onready var hud = get_parent()

func update():
	$VBox/Scroll/VBox/StatStrength/Num.text = str(DataManager.stats[Main.current_player].get_stat_value("Strength"))
	$VBox/Scroll/VBox/StatLuck/Num.text = str(DataManager.stats[Main.current_player].get_stat_value("Luck"))
	$VBox/Scroll/VBox/StatVitality/Num.text = str(DataManager.stats[Main.current_player].get_stat_value("Vitality"))
	
	$VBox/Points.text = str("Points: ", DataManager.stats[Main.current_player].get_points())
	
	if DataManager.stats[Main.current_player].get_points() > 0:
		$VBox/Scroll/VBox/StatLuck/AddStat.disabled = false
		$VBox/Scroll/VBox/StatStrength/AddStat.disabled = false
		$VBox/Scroll/VBox/StatVitality/AddStat.disabled = false
		hud.available_attributes()
	else:
		$VBox/Scroll/VBox/StatLuck/AddStat.disabled = true
		$VBox/Scroll/VBox/StatStrength/AddStat.disabled = true
		$VBox/Scroll/VBox/StatVitality/AddStat.disabled = true
		hud.available_attributes()
	

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
