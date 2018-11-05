extends Node

var occupied_spawn = []
var empty_positions = []
var current_tilemap

func _ready():
	randomize()

# Usa esto primero que nada!!
func set_current_tilemap(tilemap):
	current_tilemap = tilemap
	
	# Busca posiciones vacias y las añade a empty_positions
	#
	empty_positions.clear()
	var size = tilemap.cell_size
	
	for i in size.y:
		for j in size.x:
			if tilemap.get_cellv(Vector2(j,i)) == -1:
				empty_positions.append(Vector2(j,i))

func player_spawn(player):
	if empty_positions.size() > 0:
		var rand_num = int(round(rand_range(0, empty_positions.size() - 1)))
		var rand_empty_position = empty_positions[rand_num]
		occupied_spawn.append(rand_empty_position)
		
		# Añadir el player en la posición
		
		player.global_position = current_tilemap.map_to_world(rand_empty_position)
		player.global_position.x += 8
		player.global_position.y += 8
		current_tilemap.add_child(player)

func enemy_spawn(enemy):
	if empty_positions.size() > 0:
		var rand_num = int(round(rand_range(0, empty_positions.size() - 1)))
		var rand_empty_position = empty_positions[rand_num]
		
		if occupied_spawn.has(rand_empty_position):
			print("El enemigo ", enemy, " no a spawneado por que es un lugar ocupado")
			return
		
		occupied_spawn.append(rand_empty_position)
		
		# Añadir el enemy en la posición
		enemy.global_position = current_tilemap.map_to_world(rand_empty_position)
		enemy.global_position.x += 8
		enemy.global_position.y += 8
		current_tilemap.add_child(enemy)