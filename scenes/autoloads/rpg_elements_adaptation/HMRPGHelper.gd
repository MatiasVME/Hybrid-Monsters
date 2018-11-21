extends "res://addons/rpg_elements/nodes/RPGHelper.gd"

func get_hm_inst_character():
	return load("res://scenes/autoloads/rpg_elements_adaptation/HMCharacter.gd").new()
	
func get_hm_inst_sword():
	return load("res://scenes/autoloads/rpg_elements_adaptation/item/equipable/attack/sword/HMSword.gd").new()
	
func get_hm_inst_health_potion():
	return load("res://scenes/autoloads/rpg_elements_adaptation/item/usable/potion/HMHealth.gd").new()
	
func get_hm_inst_book():
	return load("res://scenes/autoloads/rpg_elements_adaptation/item/usable/book/HMBook.gd").new()