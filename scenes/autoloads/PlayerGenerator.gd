extends Node

func generate_first_player():
	var player = generate_player()
	
	# Define los primeros elementos del primer
	# monstruo
	player.element_1 = Main.Elements.FIRE
	player.element_2 = Main.Elements.WATER
	
	# Seleccionar un numero de skin
	var skin_num = 6
#	all_player_data["SkinNum"] = skin_num
	
	return player
	
func generate_random_player():
	pass

# Métodos "Privados"
#

func generate_player():
	var player = HMRPGHelper.get_hm_inst_character()
	
	player.character_name = RandomNameGenerator.generate()
	player.level_max = 40
	player.hp = 20
	player.max_hp = 20
	player.energy = 20
	player.max_energy = 20
	player.attack = 2
	
	return player
	
func get_random_skin_num():
	pass