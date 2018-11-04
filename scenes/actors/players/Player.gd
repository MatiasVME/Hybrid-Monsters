extends "../Actor.gd"

var character

func _ready():
	# Random Skin for test
#	randomize()
#	var random_skin = int(round(rand_range(0, Main.SKIN_AMOUNT)))
#
#	set_values(random_skin)

	$Pivot/Sprite.material.set_shader_param("c_1", Color(1,0,0))
	$Pivot/Sprite.material.set_shader_param("c_2", Color(0,1,0))
	$Pivot/Sprite.material.set_shader_param("c_3", Color(0,0,1))
	
	$Pivot/Sprite.material.set_shader_param("r_1", Elements.get_color_element(Main.WATER))
	$Pivot/Sprite.material.set_shader_param("r_2", Elements.get_color_element(Main.FIRE))
	$Pivot/Sprite.material.set_shader_param("r_3", Elements.get_color_element(Main.ELECTRIC))

func set_values(hmcharacter, skin_num):
	character = hmcharacter
	

	
	$Pivot/Sprite.texture = get_skin(skin_num)

func _process(delta):
	var input_direction = get_input_direction()
	if not input_direction:
		return
	
	var target_position = Grid.request_move(self, input_direction)
	if target_position:
		move_to(target_position)
	else:
		bump()

func get_input_direction():
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)
	
func get_skin(num):
	if num > Main.SKIN_AMOUNT:
		print("Probablemente el skin ", num, ".png no existe")
	
	var skin = load(str("res://scenes/actors/players/skins/", str(num),".png"))
	return skin