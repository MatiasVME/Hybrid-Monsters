extends Node2D

func _ready():
	pass


func _on_DNAnim_animation_finished(anim_name):
	if anim_name == "show":
		queue_free()
