extends Node

var rec_player = preload("res://scenes/actors/players/Player.tscn")

func _ready():
	$CaveGenerator.generate_floor_map($Floor, Vector2(40,40))

	$CaveGenerator.generate_walls(
		$Obstacles,
		10,
		Vector2(40, 40),
		true
	)

	var my_player = rec_player.instance()

	$Spawn.player_spawn($Obstacles, my_player)
	
	$Camera.set_focus(my_player)
	$Camera.current = true