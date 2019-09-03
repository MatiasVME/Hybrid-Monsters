extends Node

var rec_player = preload("res://scenes/actors/players/Player.tscn")
var rec_enemy = preload("res://scenes/actors/enemies/Enemy.tscn")

var size_map

func _ready():
	Main.init_game()
	
	# Random Music
	randomize()
	var music_num = int(round(rand_range(MusicManager.Music.WAR, MusicManager.Music.TUNINUNININU)))
	MusicManager.select_music(music_num)
	MusicManager.play_music()
	MusicManager.start_anim()
	
	size_map = Vector2(Main.map_size, Main.map_size)
	
	$CaveGenerator.generate_floor_map($Floor, size_map)
	
	$CaveGenerator.set_tile_wall(1)
	$CaveGenerator.generate_walls(
		$World,
		5,
		size_map,
		true
	)
	
	$CaveGenerator.add_border(Main.CellTypes.INDESTRUCTIBLE_WALL)

	var my_player = rec_player.instance()

	$Spawn.set_current_tilemap($World, size_map)
	# Primero debe spawnear el player antes de los enemigos
	$Spawn.player_spawn(my_player)
	
	# Generamos los enemigos
	for i in int(round(sqrt(Main.current_level + 1))) * 5:
		var inst_enemy = rec_enemy.instance()
		$Spawn.enemy_spawn(inst_enemy)

		# Hacemos que se eliminen al spawnear cerca del player
		if my_player.global_position.distance_to(inst_enemy.global_position) <= 16 * 8:
			print("El enemigo spawneo muy cerca, será eliminado")
			$World.remove_actor(inst_enemy)
			inst_enemy.free()
	
	# No siempre se añaden todos los enemigos
	
	Main.total_enemies = 0
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		if not enemy.is_queued_for_deletion():
			Main.total_enemies += 1
			enemy.connect("dead", self, "_on_enemy_dead", [my_player])
	
	if not Main.total_enemies == 0:
		Main.enemies_required = clamp(int(round(rand_range(1, float(Main.total_enemies) / 2))),1 , Main.total_enemies)
	else:
		$Spawn.cave_spawn(my_player)
		Main.enemies_required = 0
	
	$Camera.set_focus(my_player)
	$Camera.current = true
	$Camera.limit_left = 0
	$Camera.limit_top = 0
	$Camera.limit_right = size_map.x * 16
	$Camera.limit_bottom = size_map.y * 16
	
	# Añadimos el hud al final para que actualice los datos
	$HUD.player = my_player
	my_player.set_hud($HUD)
	$HUD.initial_config($HUD.Mode.BATTLE)
	
	# Hace que se vea bien el tilemap
	for y in size_map.y:
		for x in size_map.x:
			$World.update_bitmask_area(Vector2(x, y))
	
	DeliveryManager.get_node("Deliveries").remove_delivery("TimeToLose")
	DeliveryManager.get_node("Deliveries").create_delivery(
		"TimeToLose", 
		sqrt(Main.current_level + 1) * 80, 
		0, 
		true, 
		false
	)
	$HUD.mode = $HUD.Mode.BATTLE
	
	match Main.current_level:
		3: AchievementsManager.complete_achievement_if_can(AchievementsManager.Achievements.LVL3)
		5: AchievementsManager.complete_achievement_if_can(AchievementsManager.Achievements.LVL5)
		10: AchievementsManager.complete_achievement_if_can(AchievementsManager.Achievements.LVL10)
		15: AchievementsManager.complete_achievement_if_can(AchievementsManager.Achievements.LVL15)
	
func _on_enemy_dead(player):
	if Main.enemies_required == Main.store_destroyed_enemies:
		$Spawn.cave_spawn(player)
	
