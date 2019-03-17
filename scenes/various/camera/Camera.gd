extends Camera2D

var focus

enum Mode {MODE_FOCUS, MODE_FREE}
export (Mode) var mode = Mode.MODE_FREE

#var camera_speed = 450
#var camera_movement = Vector2()
#
#func _ready():
#	pass

func _process(delta):
	if focus == null or not current:
		return
	
	match mode:
		Mode.MODE_FOCUS:
			global_position = focus.global_position
		Mode.MODE_FREE:
			pass
	
func set_focus(_focus):
	focus = _focus
	mode = Mode.MODE_FOCUS
