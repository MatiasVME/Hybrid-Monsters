extends Camera2D

var focus

#var camera_speed = 450
#var camera_movement = Vector2()
#
#func _ready():
#	pass
	

func _process(delta):
	if focus == null or not current:
		return
	
	global_position = focus.global_position
	
	
func set_focus(_focus):
	focus = _focus
