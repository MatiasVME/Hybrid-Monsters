extends TileMap

# Se emite esta señal cuando se puede mover
signal can_move(cell_type)
# Emite esta seña cuando no se puede mover
# who: es quien no se puede mover
# why: es por que, (quién esta ahí)
signal cant_move(who, cell_dest_type, direction)

func get_cell_pawn(coordinates):
	for node in get_children():
		if world_to_map(node.position) == coordinates:
			return(node)

func remove_actor(pawn):
	var cell = world_to_map(pawn.global_position)
	set_cellv(cell, Main.EMPTY)

func remove_wall(player, direction):
	var wall = world_to_map(player.global_position)
	wall.x += direction.x
	wall.y += direction.y
	
	set_cellv(wall, Main.EMPTY)

func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.global_position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)
	
	match cell_target_type:
		Main.EMPTY, Main.FLOOR:
#			print("empty or floor")
			return update_pawn_position(pawn.type, cell_start, cell_target)
		Main.WALL, Main.ENEMY, Main.INDESTRUCTIBLE_WALL, Main.CAVE:
			print("OBSTACLE: ", cell_target_type)
			emit_signal("cant_move", pawn, cell_target_type, direction)
	
func update_pawn_position(pawn_type, cell_start, cell_target):
	set_cellv(cell_target, pawn_type)
	set_cellv(cell_start, Main.EMPTY)
	
	emit_signal("can_move", pawn_type)
	
	return map_to_world(cell_target) + cell_size / 2
