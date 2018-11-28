# HMArmor.gd
#

extends "../HMEquipable.gd"
 
var defence = 0

func update():
	if defence <= 20:
		texture_path = str("res://scenes/items/armor/skin/normal_", int(round(rand_range(1, 4))) ,".png")
		item_name = RandomNameGenerator.generate() + " Normal Armor"
	elif defence <= 30:
		texture_path = "res://scenes/items/armor/skin/iron_1.png"
		item_name = RandomNameGenerator.generate() + " Iron Armor"
		weight = 2
	elif defence <= 40:
		texture_path = "res://scenes/items/armor/skin/diamond_1.png"
		item_name = RandomNameGenerator.generate() + " Diamond Armor"
		weight = 3
	elif defence <= 50:
		texture_path = "res://scenes/items/armor/skin/ruby_1.png"
		item_name = RandomNameGenerator.generate() + " Ruby Armor"
		weight = 4
	
	item_type = ItemType.ARMOR
	
	buy_price = defence * 150
	sell_price = buy_price / 8