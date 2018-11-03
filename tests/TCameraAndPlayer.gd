extends Node

func _ready():
	$Camera.set_focus($Grid/Player)
	$Camera.current = true
