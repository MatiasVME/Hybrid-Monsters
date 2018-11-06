# Enemy.gd

extends "../Actor.gd"

var follow_player = false

func _ready():
	# Random Skin for test
	randomize()
	var random_skin = int(round(rand_range(1, Main.SKIN_NORMAL_ENEMY_AMOUNT)))
	$Pivot/Sprite.texture = get_skin(random_skin)
	
	type = Main.ENEMY
	
#	set_values(null, random_skin)

# Turno del enemigo
func turn():
	if follow_player:
		$Anim.play("bump")
	else:
		random_move()
#	print("me muevo supuestamente")

func random_move():
	var rand_dir = .get_rand_posible_dir()
	
	if rand_dir != null:
		var target_pos = Grid.request_move(self, rand_dir)
		move_to(target_pos)
	
func move_to_player():
	pass

func change_color():
	# TEMP
	$Pivot/Sprite.material.set_shader_param("c_1", Color(1,0,0))
	$Pivot/Sprite.material.set_shader_param("c_2", Color(0,1,0))
	$Pivot/Sprite.material.set_shader_param("c_3", Color(0,0,1))
	
	$Pivot/Sprite.material.set_shader_param("r_1", Elements.get_color_element_random())
	$Pivot/Sprite.material.set_shader_param("r_2", Elements.get_color_element_random())
	$Pivot/Sprite.material.set_shader_param("r_3", Elements.get_color_element_random())

func get_skin(num):
	if num > Main.SKIN_NORMAL_ENEMY_AMOUNT:
		print("Probablemente el skin ", num, ".png no existe")
	
	var skin = load(str("res://scenes/actors/enemies/skin/", str(num),".png"))
	return skin

func _on_ViewArea_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		follow_player = true

func _on_ViewArea_area_exited(area):
	if area.get_parent().is_in_group("Player"):
		follow_player = false
