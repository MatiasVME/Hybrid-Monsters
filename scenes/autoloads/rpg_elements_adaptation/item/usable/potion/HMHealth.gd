# Health
#

extends "HMPotion.gd"

var health

enum TypePotion {
	TYPE_5,
	TYPE_10,
	TYPE_15,
	TYPE_20
}
var type_potion = TypePotion.TYPE_5 setget set_type_potion, get_type_potion

func get_potion_name():
	match type_potion:
		TYPE_5:
			return "Health (5)"
		TYPE_10:
			return "Health (10)"
		TYPE_15:
			return "Health (15)"
		TYPE_20:
			return "Health (20)"
			
func set_type_potion(_type_potion):
	self.item_type = self.ItemType.POTION
	
	self.texture_path = "res://scenes/items/potions/skins/potion_health.png"
	type_potion = _type_potion
	
	match _type_potion:
		TYPE_5:
			health = 5
			self.item_name = get_potion_name()
			self.buy_price = 25
			self.sell_price = self.buy_price / 2
		TYPE_10:
			health = 10
			self.item_name = get_potion_name()
			self.buy_price = 50
			self.sell_price = self.buy_price / 2
		TYPE_15:
			health = 15
			self.item_name = get_potion_name()
			self.buy_price = 75
			self.sell_price = self.buy_price / 2
		TYPE_20:
			health = 20
			self.item_name = get_potion_name()
			self.buy_price = 100
			self.sell_price = self.buy_price / 2
	
func get_type_potion():
	return type_potion