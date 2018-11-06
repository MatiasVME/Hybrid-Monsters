extends Node

signal player_turn(players_arr)
signal enemy_turn(enemies_arr)

func enemy_turn():
	emit_signal("enemy_turn")
	
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.turn()
	
	emit_signal("player_turn")
