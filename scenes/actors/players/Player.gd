# Player.gd

extends "../Actor.gd"

var turn_helper = preload("res://scenes/various/turn_helper/TurnHelper.tscn").instance()

var character

func _ready():
	Grid.connect("can_move", self, "on_can_move")
	Grid.connect("cant_move", self, "on_cant_move")
	
	add_child(turn_helper)
	
	# Random Skin for test
	randomize()
	var random_skin = int(round(rand_range(1, Main.SKIN_PLAYER_AMOUNT)))
	
	$Pivot/Sprite.texture = get_skin(random_skin)
	
	config_character()
	
	# TEMP
	$Pivot/Sprite.material.set_shader_param("c_1", Color(1,0,0))
	$Pivot/Sprite.material.set_shader_param("c_2", Color(0,1,0))
	$Pivot/Sprite.material.set_shader_param("c_3", Color(0,0,1))
	
#	$Pivot/Sprite.material.set_shader_param("r_1", Elements.get_color_element(Main.WATER))
#	$Pivot/Sprite.material.set_shader_param("r_2", Elements.get_color_element(Main.FIRE))
#	$Pivot/Sprite.material.set_shader_param("r_3", Elements.get_color_element(Main.ELECTRIC))
	
	$Pivot/Sprite.material.set_shader_param("r_1", Elements.get_color_element_random())
	$Pivot/Sprite.material.set_shader_param("r_2", Elements.get_color_element_random())
	$Pivot/Sprite.material.set_shader_param("r_3", Elements.get_color_element_random())
	

func _process(delta):
	if is_mark_to_dead:
		return
	
	var input_direction = get_input_direction()
	if not input_direction:
		return
	
	var target_position = Grid.request_move(self, input_direction)
	# Si target no es nulo
	if target_position:
		move_to(target_position)
		
	turn_helper.enemy_turn()

func get_input_direction():
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)
	
func get_skin(num):
	if num > Main.SKIN_PLAYER_AMOUNT:
		print("Probablemente el skin ", num, ".png no existe")
	
	var skin = load(str("res://scenes/actors/players/skins/", str(num),".png"))
	return skin
	
func attack(direction):
	set_process(false)
	
	.attack()
		
	# Para testear
	var glove = load("res://scenes/items/attack/gloves/AGloves.tscn").instance()
	var enemy_pos = direction * 16
	glove.global_position = enemy_pos
	glove.z_index = 1
	glove.look_at(direction)
	
	add_child(glove)
	
	# Daño al enemigo
	for dir in $Around.get_children():
		print(dir.cast_to)
		if dir.cast_to == direction:
			var enemy = dir.get_collider()
			
			if enemy:
				enemy.damage(
					DataManager.players[Main.current_player].attack
				)
				break
	
	yield(glove.get_node("Anim"), "animation_finished")
	
	set_process(true)
	
func config_character():
	# Esto debe cambiar en un futuro ya que no solo existirá un
	# solo player.
	DataManager.players[0].connect("remove_hp", self, "_on_remove_hp")
	DataManager.players[0].connect("dead", self, "_on_dead")

func damage(damage):
	$Anim.play("damage")
	DataManager.players[0].damage(damage)
	print("damage: ", damage)

func turn():
	pass
	
func on_can_move(cell_type):
	pass
	
func on_cant_move(pawn, cell_dest_type, direction):
	if pawn.type != Main.PLAYER:
		return
	
	match cell_dest_type:
		Main.OBSTACLE:
			bump()
		Main.ENEMY:
			attack(direction)
	
func _on_remove_hp(amount):
	print("HP: ", DataManager.players[0].hp, "/", DataManager.players[0].max_hp)
	
func _on_dead():
	is_mark_to_dead = true
	Grid.remove_actor(self)
	$Anim.play("dead")