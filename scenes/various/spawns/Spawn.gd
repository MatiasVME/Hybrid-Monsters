extends Node

var occupied_spawn = []
var empty_positions = []

func _ready():
	randomize()

func player_spawn(tilemap, player):
	# Buscar una posición vacia
	empty_positions = seach_empty_position(tilemap)
	
	if empty_positions.size() > 0:
		var rand_num = int(round(rand_range(0, empty_positions.size())))
		var rand_empty_position = empty_positions[rand_num]
		occupied_spawn.append(rand_empty_position)
		
		# Añadir el player en la posición
		
		player.global_position = tilemap.map_to_world(rand_empty_position)
		player.global_position.x += 8
		player.global_position.y += 8
		tilemap.add_child(player)

# "Privados"
#

func seach_empty_position(tilemap): # arreglar
	var size = tilemap.cell_size
	
	for i in size.y:
		for j in size.x:
			if tilemap.get_cellv(Vector2(j,i)) == -1:
				empty_positions.append(Vector2(j,i))
	
	return empty_positions