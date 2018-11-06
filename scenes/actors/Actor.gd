extends Node2D

onready var Grid = get_parent()

# Debe de ser un Main.CellType
var type = Main.PLAYER

func spawn():
	pass

func move_to(target_position):
	set_process(false)
	$Anim.play("walk")

	# Move the node to the target cell instantly,
	# and animate the sprite moving from the start to the target cell
	var move_direction = (target_position - position).normalized()
	$Tween.interpolate_property(
		$Pivot,
		"position", 
		-move_direction * 16, 
		Vector2(), 
		$Anim.current_animation_length, 
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN
	)
	position = target_position

	$Tween.start()

	# Stop the function execution until the animation finished
	yield($Anim, "animation_finished")
	
	set_process(true)

func bump():
	set_process(false)
	$Anim.play("bump")
	yield($Anim, "animation_finished")
	set_process(true)
