# HMSword.gd
#

extends HMAttack

class_name HMSword

enum Form {
	NORMAL,
	JAGGED,
	WIDE
}

# Material de la espada, iron, diamond, etc.
var material
# Forma o tipo de espada
var form