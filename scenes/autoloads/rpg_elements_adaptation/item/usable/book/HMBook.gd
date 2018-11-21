# HMBook.gd
#

extends "../HMUsable.gd"

enum BookType {
	STRENGTH,
	LUCK,
	VITALITY
}

var book_type setget set_book_type

func _ready():
	self.buy_price = 5000
	self.sell_price = self.buy_price / 2

func set_book_type(_book_type):
	self.item_type = self.ItemType.BOOK
	book_type = _book_type

	match book_type:
		STRENGTH:
			self.texture_path = "res://scenes/items/books/book_strength.png"
			self.item_name = "Strength Book"
		LUCK:
			self.texture_path = "res://scenes/items/books/book_luck.png"
			self.item_name = "Luck Book"
		VITALITY:
			self.texture_path = "res://scenes/items/books/book_vitality.png"
			self.item_name = "Vitality Book"

func use():
	if book_type == null:
		print("Este libro no tiene book_type")
		return
		
	.use()
	
	# Se da un punto para que luego se use
	AttributesManager.add_points()
	
	match book_type:
		STRENGTH:
			AttributesManager.add_strength()
		LUCK:
			AttributesManager.add_luck()
		VITALITY:
			AttributesManager.add_vitality()
			