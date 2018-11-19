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
	
	var material_name = get_material_name(material)
	var max_damage = 5
	
	match material:
		Materials.WOOD:
			sword.material = Materials.WOOD
			max_damage = 5
		Materials.IRON:
			sword.material = Materials.IRON
			max_damage = 10
		Materials.DIAMOND:
			sword.material = Materials.DIAMOND
			max_damage = 15
		Materials.RUBY:
			sword.material = Materials.RUBY
			max_damage = 20
	
	var form = get_sword_form(sword)
	var form_name
	
	match form:
		sword.Form.NORMAL:
			sword.damage = int(round(clamp(float(item_level) / 3 + level_enemy, 1, max_damage)))
			form_name = "normal"
		sword.Form.JAGGED:
			sword.damage = int(round(clamp(float(item_level) / 3 + level_enemy + Main.var_dificulty * 2, 1, max_damage)))
			form_name = "jagged"
		sword.Form.WIDE:
			sword.damage = int(round(clamp(float(item_level) / 3 + level_enemy + Main.var_dificulty * 4, 1, max_damage)))
			form_name = "wide"
	
	if sword.damage < 0: sword.damage = 1
	
	sword.item_type = "sword"
	
	sword.item_name = RandomNameGenerator.generate() + " Sword"
	sword.texture_path = str("res://scenes/items/attack/swords/skins/", material_name, "-", form_name, ".png")
	
	sword.primary_element = Elements.get_random_element()
	sword.secundary_element = Elements.get_random_element()
	
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
		31, 32, 33, 34, 35, 36, 37, 38, 39, 40:
			return Materials.RUBY
		
func get_sword_form(sword):
	if randi() % 15 == 0:
		sword.form = sword.Form.WIDE
		sword.weight = 3
		return sword.form
	elif randi() % 8 == 0:
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
	
	
	
	
	
	