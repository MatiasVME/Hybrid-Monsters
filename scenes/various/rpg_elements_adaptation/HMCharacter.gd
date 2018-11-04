extends "res://addons/rpg_elements/nodes/RPGCharacter.gd"

var element_1 setget set_element_1, get_element_1
var element_2 setget set_element_2, get_element_2

func set_element_1(element_type):
	element_1 = element_type
	
func get_element_1():
	return element_1
	
func set_element_2(element_type):
	element_2 = element_type
	
func get_element_2():
	return element_2