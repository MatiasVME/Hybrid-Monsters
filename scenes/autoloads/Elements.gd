extends Node

func _ready():
	randomize()

func get_color_element(color_element):
	match int(color_element):
		Main.Elements.WATER: return Color("0098dc")
		Main.Elements.FIRE: return Color("c42430")
		Main.Elements.PLANT: return Color("5ac54f")
		Main.Elements.WIND: return Color("858585")
		Main.Elements.ROCK: return Color("1b1b1b")
		Main.Elements.GHOST: return Color("ffffff")
		Main.Elements.GROUND: return Color("5d2c28")

func get_color_element_random():
	var rand_num = int(round(rand_range(0, 7)))
	
	match rand_num:
		Main.Elements.WATER: return Color("0098dc")
		Main.Elements.FIRE: return Color("c42430")
		Main.Elements.ELECTRIC: return Color("ffc825")
		Main.Elements.PLANT: return Color("5ac54f")
		Main.Elements.WIND: return Color("858585")
		Main.Elements.ROCK: return Color("1b1b1b")
		Main.Elements.GHOST: return Color("ffffff")
		Main.Elements.GROUND: return Color("5d2c28")
		
func get_random_element():
	var rand_num = int(round(rand_range(0, 7)))
	
	match rand_num:
		Main.Elements.WATER: return Main.Elements.WATER
		Main.Elements.FIRE: return Main.Elements.FIRE
		Main.Elements.ELECTRIC: return Main.Elements.ELECTRIC 
		Main.Elements.PLANT: return Main.Elements.PLANT 
		Main.Elements.WIND: return Main.Elements.WIND 
		Main.Elements.ROCK: return Main.Elements.ROCK 
		Main.Elements.GHOST: return Main.Elements.GHOST
		Main.Elements.GROUND: return Main.Elements.GROUND




