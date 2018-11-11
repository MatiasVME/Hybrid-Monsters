extends Node

var rec_player = preload("res://scenes/actors/players/Player.tscn")
var rec_enemy = preload("res://scenes/actors/enemies/Enemy.tscn")

func _ready():
	var size_map = Vector2(100, 100)
	
	$CaveGenerator.generate_floor_map($Floor, size_map)

	$CaveGenerator.generate_walls(
		$World,
		10,
		size_map,
		true
	)
	
	$CaveGenerator.add_border(2)

	var my_player = rec_player.instance()

	$Spawn.set_current_tilemap($World, size_map)
	# Primero debe spawnear el player antes de los enemigos
	$Spawn.player_spawn(my_player)
	
	# Generamos los enemigos
	for i in 50:
		var inst_enemy = rec_enemy.instance()
		inst_enemy.change_color()
		$Spawn.enemy_spawn(inst_enemy)

		# Hacemos que no spawneen cerca del player
		if my_player.global_position.distance_to(inst_enemy.global_position) <= 16 * 8:
			print("El enemigo spawneo muy cerca, será eliminado")
			$World.remove_actor(inst_enemy)
#			is_mark_to_dead = true
			inst_enemy.queue_free()
	
	$Camera.set_focus(my_player)
	$Camera.current = true
	$Camera.limit_right = size_map.x * 16
	$Camera.limit_bottom = size_map.y * 16
	
	DataManager.players[0].debug = true
	DataManager.players[0].connect_debug_signals()
	Main.init_game()
	
	# Añadimos el hud al final para que actualice los datos
	my_player.set_hud($HUD)
	
	print("hp del player", DataManager.players[0].hp)