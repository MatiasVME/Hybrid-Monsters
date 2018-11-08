extends Node

func ready():
	randomize()

func get_random_enemy_character():
	var character = HMRPGHelper.get_hm_inst_character()
	
	if randi() % 9 == 0:
#		print("create_rand_hard_enemy")
		return create_rand_hard_enemy(character)
	elif randi() % 4 == 0:
#		print("create_rand_normal_enemy")
		return create_rand_normal_enemy(character)
	else:
#		print("create_rand_easy_enemy")
		return create_rand_easy_enemy(character)
	
func create_rand_easy_enemy(character):
	var hp = int(round(rand_range(2, 6)))
	var attack = int(round(rand_range(1, 3)))
	
	character.hp = hp
	character.max_hp = hp
	
	return character
	
func create_rand_normal_enemy(character):
	var hp = int(round(rand_range(7, 10)))
	var attack = int(round(rand_range(3, 6)))
	
	character.hp = hp
	character.max_hp = hp
	
	return character

func create_rand_hard_enemy(character):
	var hp = int(round(rand_range(11, 15)))
	var attack = int(round(rand_range(5, 8)))
	
	character.hp = hp
	character.max_hp = hp
	
	return character
