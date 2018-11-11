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

	var my_player = rec_player.instance()

	$Spawn.set_current_tilemap($World, size_map)
	# Primero debe spawnear el player antes de los enemigos
	$Spawn.player_spawn(my_player)
	
	# Generamos los enemigos
	for i in 50:
		var inst_enemy = rec_enemy.instance()
		inst_enemy.change_color()
		$Spawn.enemy_spawn(inst_enemy)
	
	$Camera.set_focus(my_player)
	$Camera.current = true
	
	DataManager.players[0].debug = true
	DataManager.players[0].connect_debug_signals()
	Main.init_game()
	
	# Añadimos el hud al final para que actualice los datos
	my_player.set_hud($HUD)
	
	print("hp del player", DataManager.players[0].hp)