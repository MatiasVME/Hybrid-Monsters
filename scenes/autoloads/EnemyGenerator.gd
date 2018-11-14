extends Node

# Dificultad del último enemigo creado
var last_enemy_dificulty

func ready():
	randomize()

func get_random_enemy_character():
	var character = HMRPGHelper.get_hm_inst_character()
	
	if randi() % 9 == 0:
#		print("create_rand_hard_enemy")
		last_enemy_dificulty = "H"
		return create_rand_hard_enemy(character)
	elif randi() % 4 == 0:
#		print("create_rand_normal_enemy")
		last_enemy_dificulty = "N"
		return create_rand_normal_enemy(character)
	else:
#		print("create_rand_easy_enemy")
		last_enemy_dificulty = "E"
		return create_rand_easy_enemy(character)
	
func create_rand_easy_enemy(character):
	var hp = int(round(rand_range(Main.var_dificulty*1.4, Main.var_dificulty*3)))
	var attack = int(round(rand_range(Main.var_dificulty, Main.var_dificulty*1.4)))
	
	print("create_rand_easy_enemy")
	print("hp = ", hp)
	print("attack = ", attack)
	
	character.hp = hp
	character.max_hp = hp
	character.attack = attack
	
	return character
	
func create_rand_normal_enemy(character):
	var hp = int(round(rand_range(Main.var_dificulty*2.5, Main.var_dificulty*4.5)))
	var attack = int(round(rand_range(Main.var_dificulty*1.4, Main.var_dificulty*2)))
	
	print("create_rand_normal_enemy")
	print("hp = ", hp)
	print("attack = ", attack)
	
	character.hp = hp
	character.max_hp = hp
	character.attack = attack
	
	return character

func create_rand_hard_enemy(character):
	var hp = int(round(rand_range(Main.var_dificulty*3.5, Main.var_dificulty*5.5)))
	var attack = int(round(rand_range(Main.var_dificulty*2.4, Main.var_dificulty*3)))
	
	print("create_rand_hard_enemy")
	print("hp = ", hp)
	print("attack = ", attack)
	
	character.hp = hp
	character.max_hp = hp
	character.attack = attack
	
	return character
