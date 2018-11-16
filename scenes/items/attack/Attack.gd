extends Node2D

var item

func _ready():
	if $Anim.has_animation("hit"):
		$Anim.play("hit")
		
		var rand_num = str(int(round(rand_range(1,4))))
		get_node(str("Hit", rand_num)).play()

func _on_Anim_animation_finished(anim_name):
	if anim_name == "hit":
		queue_free()
