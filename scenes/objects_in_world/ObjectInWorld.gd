extends KinematicBody2D

var is_solid = true

signal touched

func _ready():
	$ASprite.play("default")

func touch():
	emit_signal("touched")