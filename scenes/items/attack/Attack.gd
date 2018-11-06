extends Node2D

func _ready():
	if $Anim.has_animation("hit"):
		$Anim.play("hit")

func _on_Anim_animation_finished(anim_name):
	if anim_name == "hit":
		queue_free()
