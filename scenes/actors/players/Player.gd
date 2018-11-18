# Player.gd

extends "../Actor.gd"

var HUD # Necesita ser seteado

var turn_helper = preload("res://scenes/various/turn_helper/TurnHelper.tscn").instance()

var character

func _ready():
	Grid.connect("can_move", self, "on_can_move")
	Grid.connect("cant_move", self, "on_cant_move")
	
	add_child(turn_helper)
	
	# Random Skin for test
#	randomize()
#	var random_skin = int(round(rand_range(1, Main.SKIN_PLAYER_AMOUNT)))
	
	$Pivot/Sprite.texture = get_skin(6)
	
	config_character()
	
	# TEMP
	$Pivot/Sprite.material.set_shader_param("c_1", Color(1,0,0))
	$Pivot/Sprite.material.set_shader_param("c_2", Color(0,1,0))
	$Pivot/Sprite.material.set_shader_param("c_3", Color(0,0,1))
	
	$Pivot/Sprite.material.set_shader_param("r_1", Elements.get_color_element(Main.WATER))
	$Pivot/Sprite.material.set_shader_param("r_2", Elements.get_color_element(Main.FIRE))
	$Pivot/Sprite.material.set_shader_param("r_3", Elements.get_color_element(Main.ELECTRIC))
	
#	$Pivot/Sprite.material.set_shader_param("r_1", Elements.get_color_element_random())
#	$Pivot/Sprite.material.set_shader_param("r_2", Elements.get_color_element_random())
#	$Pivot/Sprite.material.set_shader_param("r_3", Elements.get_color_element_random())
	

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

func set_hud(_hud):
	HUD = _hud
	
	HUD.get_node("Status").update_all_status()

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
	if not directions.has(direction):
		bump()
		return
	
	set_process(false)
	
	.attack()
	
	var glove
	
	if primary_weapon_data:
		if primary_weapon_data is Main.HMSword:
			primary_weapon = ItemGenerator.get_item_in_battle(primary_weapon_data)
			var enemy_pos = direction * 16
			primary_weapon.global_position = enemy_pos
			primary_weapon.z_index = 1
			primary_weapon.look_at(direction)
			
			add_child(primary_weapon)
			
	else:
		glove = load("res://scenes/items/attack/gloves/AGloves.tscn").instance()
		var enemy_pos = direction * 16
		glove.global_position = enemy_pos
		glove.z_index = 1
		glove.look_at(direction)
		
		add_child(glove)
	
	# Daño al enemigo
	for dir in $Around.get_children():
		if dir.cast_to == direction:
			var enemy = dir.get_collider()
			
			if enemy:
				if not primary_weapon_data:
					enemy.damage(
						DataManager.players[Main.current_player].attack
					)
				else:
					enemy.damage(
						DataManager.players[Main.current_player].attack + primary_weapon_data.damage
					)
				break
	
	if glove:
		yield(glove.get_node("Anim"), "animation_finished")
	elif primary_weapon:
		yield(primary_weapon.get_node("Anim"), "animation_finished")
	
	set_process(true)
	
func config_character():
	# Esto debe cambiar en un futuro ya que no solo existirá un
	# solo player.
	DataManager.players[0].connect("remove_hp", self, "_on_remove_hp")
	DataManager.players[0].connect("dead", self, "_on_dead")
	DataManager.players[0].connect("level_up", self, "_on_level_up")
	DataManager.players[0].connect("add_xp", self, "_on_add_xp")

func damage(damage):
	$Anim.play("damage")
	DataManager.players[0].damage(damage)
	
func turn():
	pass
	

func mine(direction):
	if not directions.has(direction):
		bump()
		return
	
	set_process(false)
	
	# Para testear
	var pickaxe = load("res://scenes/items/tools/pickaxes/Pickaxe.tscn").instance()
	var wall_pos = direction * 16
	pickaxe.global_position = wall_pos
	pickaxe.z_index = 1
	pickaxe.get_node("Sprite").look_at(-direction)
	
	add_child(pickaxe)
	
	for dir in $Around.get_children():
		if dir.cast_to == direction:
			Grid.remove_wall(self, direction)
	
	yield(pickaxe.get_node("Anim"), "animation_finished")
	
	set_process(true)

func on_can_move(cell_type):
	pass
	
func on_cant_move(pawn, cell_dest_type, direction):
	if pawn.type != Main.PLAYER:
		return
	
	print(cell_dest_type, "=", Main.CAVE)
	
	match cell_dest_type:
		Main.WALL:
			mine(direction)
		Main.INDESTRUCTIBLE_WALL:
			bump()
		Main.ENEMY:
			attack(direction)
		Main.CAVE:
			set_process(false)
			HUD.win()
			yield(HUD.get_node("AnimWinLost"), "animation_finished")
			set_process(true)
			
func _on_remove_hp(amount):
	var damage_num = rec_damage_num.instance()
	damage_num.get_node("Num").text = str("-", amount)
	add_child(damage_num)

	if HUD:
		HUD.get_node("Status").update_hp_progress()
	
func _on_dead():
	is_mark_to_dead = true
	Grid.remove_actor(self)
	
	DataManager.save_players()
	
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.get_node("Anim").play("win")
	
	$Anim.play("dead")
	
func _on_level_up(current_level):
	DataManager.players[0].hp += 4
	DataManager.players[0].max_hp += 4
	
	if int(current_level) % 3 == 0:
		DataManager.players[0].attack += 1
#		print("=o attack=",DataManager.players[0].attack)

	var effect_level_up = load("res://scenes/effects/level_up/LevelUp.tscn").instance()
	add_child(effect_level_up)
	effect_level_up.position.x += 8
	effect_level_up.position.y -= 8
	
	DataManager.save_players()
	
func _on_add_xp(amount):
#	print("xp_add: ", amount)
#	print("xp_requerida: ", DataManager.players[0].get_xp_required(DataManager.players[0].get_level() + 1))
#	print("level: ", DataManager.players[0].get_level())
	
	if HUD:
		HUD.get_node("Status").update_xp_progress()