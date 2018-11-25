extends Node

func add_points(points_amount=1):
	DataManager.stats[Main.current_player].add_points(points_amount)
	
	# No debe guardar
	
func add_strength():
	DataManager.stats[Main.current_player].add_points_to_stat(1, "Strength")
	
	DataManager.inventories[Main.current_player].add_max_weight(3)
	
	DataManager.save_stats()
	DataManager.save_inventories()

func add_luck():
	DataManager.stats[Main.current_player].add_points_to_stat(1, "Luck")
	
	DataManager.save_stats()
	
func add_vitality():
	DataManager.stats[Main.current_player].add_points_to_stat(1, "Vitality")
	
	DataManager.players[0].hp += 1
	DataManager.players[0].max_hp += 1
	
	DataManager.save_players()
	DataManager.save_stats()