# HMAttack.gd
#

extends "../HMEquipable.gd"

var damage = 1

var primary_element setget set_primary_element, get_primary_element
var primary_element_name

var secundary_element setget set_secundary_element, get_secundary_element
var secundary_element_name

func set_primary_element(_primary_element):
	primary_element = _primary_element
	primary_element_name = get_element_name(_primary_element)
	
func get_primary_element():
	return primary_element
	
func set_secundary_element(_secundary_element):
	secundary_element = _secundary_element
	secundary_element_name = get_element_name(_secundary_element)
	
func get_secundary_element():
	return secundary_element
	
func get_element_name(element):
	match element:
		Main.Elements.WATER: return "water"
		Main.Elements.FIRE: return "fire"
		Main.Elements.ELECTRIC: return "electric"
		Main.Elements.PLANT: return "plant"
		Main.Elements.WIND: return "wind"
		Main.Elements.ROCK: return "rock"
		Main.Elements.GHOST: return "ghost"
		Main.Elements.GROUND: return "ground"
		