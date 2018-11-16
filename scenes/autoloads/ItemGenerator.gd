extends Node

# -SCOPE | NIVEL | +SCOPE
const SCOPE = 5

enum Materials {
	WOOD,
	IRON,
	DIAMOND,
	RUBY
}

func get_random_sword_from_enemy(player_level, level_enemy):
	var item_level = get_random_item_level(player_level, level_enemy)
	var material = get_material(item_level)
		
	var sword = HMRPGHelper.get_hm_inst_sword()
	sword.damage = item_level / 2 + 1
	
	var sword_name
	
	match material:
		Materials.WOOD:
			sword_name = "Wood Sword"
		Materials.IRON:
			sword_name = "Iron Sword"
	
	sword.item_name = sword_name
	
	return sword

func get_random_item_level(player_level, level_enemy):
	return int(round(rand_range(player_level - SCOPE - (level_enemy/2), player_level + SCOPE + (level_enemy / 2))))

# Devuelve el material del item
func get_material(item_level):
	match item_level:
		1, 2, 3, 4, 5, 6, 7, 8, 9, 10:
			return Materials.WOOD
		11, 12, 13, 14, 15, 16, 17, 18, 19, 20:
			return Materials.IRON
		# TODO