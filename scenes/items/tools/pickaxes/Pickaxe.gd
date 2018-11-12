extends Node2D

export (float) var time_to_break = 1.0

func _ready():
	$Tween.interpolate_property(
		self,
		"rotation_degrees", 
		45, 
		-90, 
		time_to_break,
		Tween.TRANS_ELASTIC, 
		Tween.EASE_OUT
	)
	$Tween.interpolate_property(
		self,
		"scale", 
		Vector2(1,1), 
		Vector2(0, 0), 
		time_to_break/2/2/2,
		Tween.TRANS_CIRC, 
		Tween.EASE_OUT,
		time_to_break/2
	)
	
	$Tween.start()
	$Anim.play("show")

#func _input(event):
#	if event.is_action_pressed("ui_accept"):
#		$Tween.start()
#		$Anim.play("show")

func _on_Tween_tween_completed(object, key):
	queue_free()
