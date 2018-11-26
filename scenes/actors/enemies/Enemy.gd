# Enemy.gd

extends "../Actor.gd"

var character

var follow_player = false
var players

signal dead

func _ready():
	# Random Skin for test
	randomize()
	var random_skin = int(round(rand_range(1, Main.SKIN_NORMAL_ENEMY_AMOUNT)))
	$Pivot/Sprite.texture = get_skin(random_skin)
	
	type = Main.ENEMY
	
	# Configura el character con datos aleatorios
	config_hm_character()
	
	# Asignamos los colores del enemigo
	change_color()
	
	# Obtenemos los players para acceder a ellos más fácilmente
	players = get_tree().get_nodes_in_group("Player")
	
# Turno del enemigo
func turn():
	if is_mark_to_dead:
		return
	
	if follow_player:
		move_or_attack()
	else:
		random_move()

func random_move():
	if is_mark_to_dead:
		return
	
	var rand_dir = .get_rand_posible_dir()
	
	if rand_dir != null:
		var target_pos = Grid.request_move(self, rand_dir)
		move_to(target_pos)
	
func move_or_attack():
	if is_mark_to_dead:
		return
	
	var players_amount = players.size()
	
	if players_amount == 1:
		# No hay que verificar la distancia
		
		var player_around = get_players_around_dir(players_amount)
		if player_around.size() == 1:
			attack(players[0])
		else:
			move_to_player(players[0])
	elif players_amount > 1:
		# Hay que verficiar la distancia
		pass
	else:
		# No hay players
		return
		
func config_hm_character():
	character = EnemyGenerator.get_random_enemy_character()
	$DificultyNum/Num.text = str(character.level)
	
	# Le agregamos una espada al enemigo
	if randi() % 3 == 0:
		primary_weapon_data = ItemGenerator.get_random_sword_from_enemy(DataManager.players[0].level, character.level)
		
		$CurrentWeapon.texture = load(primary_weapon_data.texture_path)
		
		$CurrentWeapon.material.set_shader_param("r_1", Elements.get_color_element(primary_weapon_data.primary_element))
		$CurrentWeapon.material.set_shader_param("r_2", Elements.get_color_element(primary_weapon_data.secundary_element))
		
	character.connect("remove_hp", self, "_on_remove_hp")
	character.connect("dead", self, "_on_dead")
	
	$LifeBar.max_value = character.max_hp
	$LifeBar.value = character.hp
	
func get_players_around_dir(players_num):
	if is_mark_to_dead:
		return
	
	if players_num == 0:
		print("No hay jugadores en el mapa, como para que funcione is_player_around()")
		return
	
	var enemy_pos = Grid.world_to_map(global_position)
	# Puede haber mas de un player atacando
	var player_positions = []
	
	for dir in directions:
		var search_pos = enemy_pos
		search_pos.x += dir.x
		search_pos.y += dir.y
		
		if Grid.get_cellv(search_pos) == Main.PLAYER:
			player_positions.append(dir)
			
			if players_num == 1:
				return player_positions
			
	return player_positions

func move_to_player(player):
	if is_mark_to_dead:
		return
	
	var dir = (player.global_position - global_position).normalized()
	dir = Vector2(int(round(dir.x)), int(round(dir.y)))
	
	# Ver si en la dirección hay murallas 
	var new_pos = Grid.request_move(self, dir)
	
	if new_pos != null:
		.move_to(new_pos)
	else:
		random_move()

func attack(player):
	if is_mark_to_dead:
		return
		
	var player_dir = get_players_around_dir(1)[0]
	
#	print("PrimaryWeaponData: ", primary_weapon_data)
	
	if primary_weapon_data != null:
		var sword = load("res://scenes/items/attack/swords/Sword.tscn").instance()
		sword.item = primary_weapon_data
		var player_pos = player_dir * 16
		sword.global_position = player_pos
		sword.z_index = 1
		sword.look_at(player_dir)
		
		add_child(sword)
#		print("atacando con espada!!! :b")
		
		player.damage(character.get_attack() + primary_weapon_data.damage)
		yield(sword.get_node("Anim"), "animation_finished")
	else:
		var glove = load("res://scenes/items/attack/gloves/AGloves.tscn").instance()
		var player_pos = player_dir * 16
		glove.global_position = player_pos
		glove.z_index = 1
		glove.look_at(player_dir)
		
		add_child(glove)
		
		player.damage(character.get_attack())
		yield(glove.get_node("Anim"), "animation_finished")
	
	set_process(true)

# Recibe daño
func damage(amount):
	if is_mark_to_dead:
		return
		
	# Si existe character
	if character:
		character.damage(amount)

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

func drop_item(hm_item):
	var dropped_item = load("res://scenes/items/DroppedItem.tscn").instance()
	get_parent().add_child(dropped_item)
	
	dropped_item.hm_item = hm_item
	dropped_item.update()
	
	dropped_item.global_position = global_position
	dropped_item.rotation_degrees = int(rand_range(0, 360))
	
	SoundManager.play_sound(SoundManager.DROP)

func drop():
	# Probabilidad de dropeo de arma primaria
	#
	
	var drop_primary_weapon = clamp(
		6.0 - (
			DataManager.stats[Main.current_player].get_stat_value("Luck") / 4
		), 
		1, 
		6
	)
	
	if randi() % int(round(drop_primary_weapon)) == 0:
		if primary_weapon_data:
			drop_item(primary_weapon_data)
	
	# Probabilidad de dropeo de una pocion
	#
	
	var drop_potion = clamp(
		10.0 - (
			DataManager.stats[Main.current_player].get_stat_value("Luck") / 2
		), 
		3, 
		10
	)
	
	if randi() % int(round(drop_potion)) == 0:
		drop_item(ItemGenerator.get_random_health_potion())
		
	# Probabilidad de dropeo de un libro
	var drop_book = clamp(
		20.0 - (
			DataManager.stats[Main.current_player].get_stat_value("Luck") / 2
		), 
		10, 
		20
	)
	
	if randi() % int(round(drop_book)) == 0:
		drop_item(ItemGenerator.get_random_book())
		
	# MoneyDrop
	Main.current_gold += character.drop_gold
	Main.store_gold += character.drop_gold

# Signals
#

func _on_remove_hp(amount):
	if is_mark_to_dead:
		return
		
	var damage_num = rec_damage_num.instance()
	damage_num.get_node("Num").text = str("-", amount)
	add_child(damage_num)
	
	$LifeBar.value = character.hp
	
	$Anim.play("damage")
	
func _on_dead():
	is_mark_to_dead = true
	Grid.remove_actor(self)
	
	Main.store_xp += character.xp_drop
	DataManager.players[Main.current_player].add_xp(character.xp_drop)
	
	Main.store_destroyed_enemies += 1
	
	# Dropeo
	drop()
	
	emit_signal("dead")
	$Anim.play("dead")
	
func _on_ViewArea_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		follow_player = true

func _on_ViewArea_area_exited(area):
	if area.get_parent().is_in_group("Player"):
		follow_player = false

func _on_Anim_animation_finished(anim_name):
	if anim_name == "dead":
		queue_free()
