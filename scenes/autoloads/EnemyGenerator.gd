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
	var hp = int(round(rand_range(Main.var_dificulty*4, Main.var_dificulty*8)))
	var attack = int(round(rand_range(Main.var_dificulty, Main.var_dificulty*1.4)))
	
#	print("create_rand_easy_enemy")
#	print("hp = ", hp)
#	print("attack = ", attack)
	
	character.max_hp = hp
	character.hp = hp
	character.attack = attack
	character.xp_drop = int(Main.var_dificulty)
	
	return character
	
func create_rand_normal_enemy(character):
	character.level_up()
	
	var hp = int(round(rand_range(Main.var_dificulty*8, Main.var_dificulty*12)))
	var attack = int(round(rand_range(Main.var_dificulty*1.4, Main.var_dificulty*2)))
	
#	print("create_rand_normal_enemy")
#	print("hp = ", hp)
#	print("attack = ", attack)
	
	character.max_hp = hp
	character.hp = hp
	character.attack = attack
	character.xp_drop = int(Main.var_dificulty * character.level)
	
	return character

func create_rand_hard_enemy(character):
	character.level_up()
	character.level_up()
	
	var hp = int(round(rand_range(Main.var_dificulty*12, Main.var_dificulty*16)))
	var attack = int(round(rand_range(Main.var_dificulty*2.4, Main.var_dificulty*3)))
	
#	print("create_rand_hard_enemy")
#	print("hp = ", hp)
#	print("attack = ", attack)
	
	character.max_hp = hp
	character.hp = hp
	character.attack = attack
	character.xp_drop = int(Main.var_dificulty * character.level)
	
	return character
