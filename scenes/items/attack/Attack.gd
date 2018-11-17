extends Node2D

var item

func _ready():
	if $Anim.has_animation("hit"):
		$Anim.play("hit")
		
		var rand_sound = int(round(rand_range(SoundManager.HIT_1, SoundManager.HIT_4)))
		SoundManager.play_sound(rand_sound)

func _on_Anim_animation_finished(anim_name):
	if anim_name == "hit":
		queue_free()
