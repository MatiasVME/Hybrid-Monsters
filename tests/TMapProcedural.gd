extends Node

var rec_player = preload("res://scenes/actors/players/Player.tscn")
var rec_enemy = load("res://scenes/actors/enemies/Enemy.tscn")

func _ready():
	$CaveGenerator.generate_floor_map($Floor, Vector2(100,100))

	$CaveGenerator.generate_walls(
		$Obstacles,
		10,
		Vector2(100, 100),
		true
	)

	var my_player = rec_player.instance()

	$Spawn.set_current_tilemap($Obstacles)
	$Spawn.player_spawn(my_player)
	
	# Generamos los enemigos
	for i in 10:
		var inst_enemy = rec_enemy.instance()
		inst_enemy.change_color()
		$Spawn.enemy_spawn(inst_enemy)
	
	$Camera.set_focus(my_player)
	$Camera.current = true