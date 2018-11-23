extends Node2D

func _ready():
	$Anim.play("show")

func _on_Anim_animation_finished(anim_name):
	if anim_name == "show":
		queue_free()
