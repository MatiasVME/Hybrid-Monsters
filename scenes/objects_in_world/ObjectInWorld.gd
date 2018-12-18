extends KinematicBody2D

var is_solid = true

signal touched(who)

func _ready():
	$ASprite.play("default")

func touch(who):
	var anim = who.get_node("Anim")
	
	if is_solid and not anim.is_playing():
		anim.play("touch")
		emit_signal("touched", who)