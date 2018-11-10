extends Node2D

func _ready():
	update_all_status()
	
func update_all_status():
	update_hp_progress()
	update_xp_progress()

func update_hp_progress():
	if DataManager.players.size() > 0:
		$HPProgress.value = DataManager.players[Main.current_player].hp
		$HPProgress.max_value = DataManager.players[Main.current_player].max_hp
		
func update_xp_progress():
	if DataManager.players.size() > 0:
		$XPProgress.value = DataManager.players[Main.current_player].xp
		var xp_required = DataManager.players[Main.current_player].get_xp_required(DataManager.players[Main.current_player].get_level())
		$XPProgress.max_value = xp_required
		$XPProgress/Level.text = str(DataManager.players[Main.current_player].get_level())
		
