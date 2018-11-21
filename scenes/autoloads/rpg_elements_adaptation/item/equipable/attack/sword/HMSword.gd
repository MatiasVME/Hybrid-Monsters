# HMSword.gd
#

extends "../HMAttack.gd"

enum Form {
	NORMAL,
	JAGGED,
	WIDE
}

# Material de la espada, iron, diamond, etc.
var material
# Forma o tipo de espada
var form