# Player.gd

extends "res://scenes/actors/Actor.gd"

class_name Player

var HUD # Necesita ser seteado

var turn_helper = preload("res://scenes/various/turn_helper/TurnHelper.tscn").instance()

var character

# ObjectInWorld que toca
var my_object

func _ready():
	Grid.connect("can_move", self, "on_can_move")
	Grid.connect("cant_move", self, "on_cant_move")
	
	add_child(turn_helper)
	
	$Pivot/Sprite.texture = get_skin(6)
	
	config_character()
	
	# TEMP
	$Pivot/Sprite.material.set_shader_param("c_1", Color(1,0,0))
	$Pivot/Sprite.material.set_shader_param("c_2", Color(0,1,0))
	$Pivot/Sprite.material.set_shader_param("c_3", Color(0,0,1))
	
	$Pivot/Sprite.material.set_shader_param("r_1", Elements.get_color_element(Main.Elements.WATER))
	$Pivot/Sprite.material.set_shader_param("r_2", Elements.get_color_element(Main.Elements.FIRE))
	$Pivot/Sprite.material.set_shader_param("r_3", Elements.get_color_element(Main.Elements.ELECTRIC))
	
func _process(delta):
	if is_mark_to_dead or not can_move:
		return
	
	var input_direction = get_input_direction()
	if not input_direction:
		return
	
	my_object = null
	my_object = get_a_object(input_direction)
	if my_object:
		my_object.touch(self)
		
		if my_object.is_solid:
			return
	
	var target_position = Grid.request_move(self, input_direction)
	# Si target no es nulo
	if target_position:
		move_to(target_position)
		
		if Main.arrow_active and self.global_position.distance_to(Main.spawn_location) >= 16*3:
			if not $Arrow.visible:
				$Arrow/Anim.play("show")
			
			$Arrow.visible = true
			$Arrow.look_at(Main.spawn_location)
		else:
			$Arrow.visible = false
			
	turn_helper.enemy_turn()

# Devuelve un object si es que existe si no existe no
# devuelve null
func get_a_object(direction):
	for ray in $Around.get_children():
		# se debe poner is_colliding sino funciona mal...
		if ray.is_colliding() and ray.cast_to == direction and ray.get_collider() and ray.get_collider().is_in_group("ObjectInWorld"):
			return ray.get_collider()
	
func set_hud(_hud):
	HUD = _hud
	
	HUD.get_node("Status").update_all_status()
	HUD.get_node("Inventory").connect("drop_item", self, "_on_drop_item")
	
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
	
	.attack(direction)
	
	var glove
	
	if primary_weapon_data:
		if primary_weapon_data is HMSword:
			primary_weapon = ItemGenerator.get_item_sword_in_battle(primary_weapon_data)
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
	
	var total_damage = 0
	
	# Daño al enemigo
	for dir in $Around.get_children():
		if dir.cast_to == direction:
			var enemy = dir.get_collider()
			
			if enemy:
				if not primary_weapon_data:
					total_damage = DataManager.players[Main.current_player].attack
				else:
					total_damage = DataManager.players[Main.current_player].attack + primary_weapon_data.damage
				
				if enemy.armor_data:
					total_damage -= int(round(float(total_damage) * enemy.armor_data.defence / 100)) 
				
				enemy.damage(total_damage)
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

func monster_say(text : String):
	$MonsterSay/Say.text = text
	$MonsterSay/Say/Anim.play("Show")

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
	
	SoundManager.play_sound(SoundManager.Sound.MINE)
	
	yield(pickaxe.get_node("Anim"), "animation_finished")
	
	set_process(true)

func on_can_move(cell_type):
	pass
	
func on_cant_move(pawn, cell_dest_type, direction):
	if pawn.type != Main.CellTypes.PLAYER:
		return
	
#	print(cell_dest_type, "=", Main.CellTypes.CAVE)
	
	match cell_dest_type:
		Main.CellTypes.WALL:
			mine(direction)
		Main.CellTypes.INDESTRUCTIBLE_WALL:
			bump()
		Main.CellTypes.ENEMY:
			attack(direction)
		Main.CellTypes.CAVE:
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
		
		if not HUD.get_node("Potion").visible:
			HUD.update_potion_button()
	
func _on_dead():
	is_mark_to_dead = true
	Grid.remove_actor(self)
	
	DataManager.save_players()
	
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.get_node("Anim").play("win")
	
	$Anim.play("dead")
	
func _on_level_up(current_level):
	if int(current_level) % 3 == 0:
		DataManager.players[0].attack += 1
#		print("=o attack=",DataManager.players[0].attack)
	
	var effect_level_up = load("res://scenes/effects/level_up/LevelUp.tscn").instance()
	add_child(effect_level_up)
	effect_level_up.position.x += 8
	effect_level_up.position.y -= 8
	
	# Se da uno de HP por cada nivel
	DataManager.players[0].hp += 1
	DataManager.players[0].max_hp += 1
	
	DataManager.stats[Main.current_player].add_points(3)
	
	HUD.get_node("Attributes").update()
	
	DataManager.save_stats()
	DataManager.save_players()
	
func _on_add_xp(amount):
#	print("xp_add: ", amount)
#	print("xp_requerida: ", DataManager.players[0].get_xp_required(DataManager.players[0].get_level() + 1))
#	print("level: ", DataManager.players[0].get_level())
	
	if HUD:
		HUD.get_node("Status").update_xp_progress()
		
func _on_drop_item(drop):
	# TODO: Lo ideal sería que dropeara items alrededor
	# del player
	
	var dropped_item = load("res://scenes/items/DroppedItem.tscn").instance()
	get_parent().add_child(dropped_item)
	
	dropped_item.hm_item = drop
	dropped_item.update()
	
	dropped_item.global_position = global_position
	dropped_item.rotation_degrees = int(rand_range(0, 360))

func _on_PlayerArea_area_entered(area):
	if area.get_parent() is DroppedItem:
		monster_say("Press Space to get the item")



