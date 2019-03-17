# HMItem.gd
#

extends "res://addons/rpg_elements/nodes/RPGItem.gd"

class_name HMItem

enum Materials {
	WOOD,
	IRON,
	DIAMOND,
	RUBY
}

enum ItemType {
	GLOVES,
	SWORD,
	POTION,
	BOOK,
	ARMOR
}
var item_type = ItemType.GLOVES

func get_item_type_name():
	match int(self.item_type):
		ItemType.GLOVES:
			return "Gloves"
		ItemType.SWORD:
			return "Sword"
		ItemType.POTION:
			return "Potion"
		ItemType.BOOK:
			return "Book"
		ItemType.ARMOR:
			return "Armor"
	
