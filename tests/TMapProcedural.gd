extends Node

func _ready():
	$CaveGenerator.generate_floor_map($Floor, Vector2(40,40))

	$CaveGenerator.generate_walls(
		$Walls,
		10,
		Vector2(40, 40),
		true
	)

	$Camera.set_focus($Walls/Player)
	$Camera.current = true
#	$Camera.zoom *= 5