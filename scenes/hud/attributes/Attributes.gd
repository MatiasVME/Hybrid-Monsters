extends Node2D

func _ready():
	pass

func update():
	$VBox/Scroll/VBox/StatStrength/Num.text = str(DataManager.stats[Main.current_player].get_stat_value("Strength"))
	$VBox/Scroll/VBox/StatLuck/Num.text = str(DataManager.stats[Main.current_player].get_stat_value("Luck"))
	$VBox/Scroll/VBox/StatVitality/Num.text = str(DataManager.stats[Main.current_player].get_stat_value("Vitality"))
	
	$VBox/Points.text = str("Points: ", DataManager.stats[Main.current_player].get_points())
	
	if DataManager.stats[Main.current_player].get_points() > 0:
		$VBox/Scroll/VBox/StatLuck/AddStat.disabled = false
		$VBox/Scroll/VBox/StatStrength/AddStat.disabled = false
		$VBox/Scroll/VBox/StatVitality/AddStat.disabled = false
	else:
		$VBox/Scroll/VBox/StatLuck/AddStat.disabled = true
		$VBox/Scroll/VBox/StatStrength/AddStat.disabled = true
		$VBox/Scroll/VBox/StatVitality/AddStat.disabled = true
	

func _on_AddStat_Strength_pressed():
	DataManager.stats[Main.current_player].add_points_to_stat(1, "Strength")
	update()
	
	DataManager.inventories[Main.current_player].max_weight += 6
	
	DataManager.save_stats()
	DataManager.save_inventories()

func _on_AddStat_Luck_pressed():
	DataManager.stats[Main.current_player].add_points_to_stat(1, "Luck")
	update()
	
	DataManager.save_stats()

func _on_AddStat_Vitality_pressed():
	DataManager.stats[Main.current_player].add_points_to_stat(1, "Vitality")
	update()
	
	DataManager.players[0].hp += 4
	DataManager.players[0].max_hp += 4
	
	DataManager.save_players()
	DataManager.save_stats()
	
