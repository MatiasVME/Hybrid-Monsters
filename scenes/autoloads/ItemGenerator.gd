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
	sword.damage = int(float(item_level) / 2 + 1)
	
	var material_name
	
	match material:
		Materials.WOOD:
			sword.material = Materials.WOOD
			material_name = "wood"
		Materials.IRON:
			sword.material = Materials.IRON
			material_name = "iron"
		Materials.DIAMOND:
			sword.material = Materials.DIAMOND
			material_name = "diamond"
		Materials.RUBY:
			sword.material = Materials.RUBY
			material_name = "ruby"
	
	var form = get_sword_form(sword)
	var form_name
	
	match form:
		sword.Form.NORMAL:
			sword.damage -= int(round(clamp(Main.var_dificulty * 2, 1, 10)))
			form_name = "normal"
		sword.Form.JAGGED:
			sword.damage -= int(round(clamp(Main.var_dificulty / 2, 3, 20)))
			form_name = "jagged"
		sword.Form.WIDE:
			sword.damage -= int(round(clamp(Main.var_dificulty / 3, 8, 30)))
			form_name = "wide"
	
	if sword.damage < 0: sword.damage = 1
	
	sword.item_type = "sword"
	
	sword.item_name = form_name.capitalize() + " " + material_name.capitalize() + " " + sword.item_type.capitalize()
	sword.texture_path = str("res://scenes/items/attack/swords/skins/", material_name, "-", form_name, ".png")
	
	return sword

func get_random_item_level(player_level, level_enemy):
	return clamp(int(round(rand_range(player_level - SCOPE - (level_enemy/2), player_level + SCOPE + (level_enemy / 2)))), 1, 100)

# Devuelve el material del item
func get_material(item_level):
	match item_level:
		1, 2, 3, 4, 5, 6, 7, 8, 9, 10:
			return Materials.WOOD
		11, 12, 13, 14, 15, 16, 17, 18, 19, 20:
			return Materials.IRON
		21, 22, 23, 24, 25, 26, 27, 28, 29, 30:
			return Materials.DIAMOND
		
func get_sword_form(sword):
	if randi() % 50 == 0:
		sword.form = sword.Form.WIDE
		sword.weight = 3
		return sword.form
	elif randi() % 20 == 0:
		sword.form = sword.Form.JAGGED
		sword.weight = 2
		return sword.form
	else:
		sword.form = sword.Form.NORMAL
		return sword.form

func get_item_image(hm_item):
	if hm_item is Main.HMSword:
		hm_item.texture_path = str(
			"res://scenes/items/attack/swords/skins/", 
			get_material_name(hm_item.material), 
			"-", 
			get_sword_form_name(hm_item), 
			".png"
		)

func get_item_in_battle(hm_item):
	var item_in_battle = load("res://scenes/items/attack/swords/Sword.tscn").instance()
	item_in_battle.item = hm_item
	return item_in_battle

func get_material_name(material):
	match material:
		Materials.WOOD:
			return "wood"
		Materials.IRON:
			return "iron"
		Materials.DIAMOND:
			return "diamond"
		Materials.RUBY:
			return "ruby"
			
func get_sword_form_name(item):
	match item.form:
		item.Form.NORMAL:
			return "normal"
		item.Form.JAGGED:
			return "jagged"
		item.Form.WIDE:
			return "wide"
	
	
	
	
	
	