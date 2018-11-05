extends TileMap

func get_cell_pawn(coordinates):
	for node in get_children():
		if world_to_map(node.position) == coordinates:
			return(node)

func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)
	print("cell_target_type: ", cell_target_type)
	match cell_target_type:
		Main.EMPTY:
			print("empty")
			return update_pawn_position(pawn.type, cell_start, cell_target)
		Main.OBJECT:
			print("object")
			var object_pawn = get_cell_pawn(cell_target)
			object_pawn.queue_free()
			return update_pawn_position(pawn.type, cell_start, cell_target)
		Main.ENEMY:
			print("ENEMY")
			var pawn_name = get_cell_pawn(cell_target).name
			print("Cell %s contains %s" % [cell_target, pawn_name])

func update_pawn_position(pawn_type, cell_start, cell_target):
#	print(pawn.type)
	set_cellv(cell_target, pawn_type)
	set_cellv(cell_start, Main.EMPTY)
	return map_to_world(cell_target) + cell_size / 2
