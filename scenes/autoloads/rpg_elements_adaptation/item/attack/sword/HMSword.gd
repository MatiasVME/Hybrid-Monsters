# HMSword.gd
#

extends "../HMAtack.gd"

enum Form {
	NORMAL,
	JAGGED,
	WIDE
}

# Material de la espada, iron, diamond, etc.
var material
# Forma o tipo de espada
var form

func _ready():
	item_type = ItemType.SWORD
