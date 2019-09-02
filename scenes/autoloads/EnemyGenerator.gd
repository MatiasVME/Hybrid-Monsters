extends Node

func ready():
	randomize()

func get_random_enemy_character():
	var character = HMRPGHelper.get_hm_inst_character()
	
	if randi() % 14 == 0:
		return create_rand_hard_enemy(character)
	elif randi() % 4 == 0:
		return create_rand_normal_enemy(character)
	else:
		return create_rand_easy_enemy(character)
		
func create_rand_easy_enemy(character):
	var hp = int(round(rand_range((Main.current_level + 1) * 2, (Main.current_level + 1) * 3)))
	var attack = int(round(rand_range((Main.current_level + 1), sqrt(Main.current_level + 1) * 1.2)))
	
	print("create_rand_easy_enemy")
	print("hp = ", hp)
	print("attack = ", attack)
	
	character.max_hp = hp
	character.hp = hp
	character.attack = attack
	character.xp_drop = int(sqrt(Main.current_level + 1))
	character.drop_gold = int(rand_range(30.0, 40.0) * sqrt(Main.current_level + 1))
	
	return character
	
func create_rand_normal_enemy(character):
	character.level_up()
	
	var hp = int(round(rand_range((Main.current_level + 1) * 3, (Main.current_level + 1)*4)))
	var attack = int(round(rand_range((Main.current_level + 1) * 1.4, sqrt(Main.current_level + 1) * 1.5)))
	
	print("create_rand_normal_enemy")
	print("hp = ", hp)
	print("attack = ", attack)
	
	character.max_hp = hp
	character.hp = hp
	character.attack = attack
	character.xp_drop = int((Main.current_level + 1))
	character.drop_gold = int(rand_range(40.0, 60.0) * sqrt(Main.current_level + 1))
	
	return character

func create_rand_hard_enemy(character):
	character.level_up()
	character.level_up()
	
	var hp = int(round(rand_range((Main.current_level + 1) * 4, (Main.current_level + 1) * 5)))
	var attack = int(round(rand_range((Main.current_level + 1) * 2.4, sqrt(Main.current_level + 1) * 2)))
	
	print("create_rand_hard_enemy")
	print("hp = ", hp)
	print("attack = ", attack)
	
	character.max_hp = hp
	character.hp = hp
	character.attack = attack
	character.xp_drop = int((Main.current_level + 1))
	character.drop_gold = int(rand_range(60.0, 80.0) * sqrt(Main.current_level + 1))
	
	return character
