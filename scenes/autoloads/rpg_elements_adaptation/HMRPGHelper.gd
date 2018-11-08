extends "res://addons/rpg_elements/nodes/RPGHelper.gd"

func get_hm_inst_character():
	return load("res://scenes/autoloads/rpg_elements_adaptation/HMCharacter.gd").new()
