extends Node

func _ready():
	randomize()

func get_color_element(color_element):
	match int(color_element):
		Main.WATER: return Color("0098dc")
		Main.FIRE: return Color("c42430")
		Main.ELECTRIC: return Color("ffc825")
		Main.PLANT: return Color("5ac54f")
		Main.WIND: return Color("858585")
		Main.ROCK: return Color("1b1b1b")
		Main.GHOST: return Color("ffffff")
		Main.GROUND: return Color("5d2c28")

func get_color_element_random():
	var rand_num = int(round(rand_range(0, 7)))
	
	match rand_num:
		Main.WATER: return Color("0098dc")
		Main.FIRE: return Color("c42430")
		Main.ELECTRIC: return Color("ffc825")
		Main.PLANT: return Color("5ac54f")
		Main.WIND: return Color("858585")
		Main.ROCK: return Color("1b1b1b")
		Main.GHOST: return Color("ffffff")
		Main.GROUND: return Color("5d2c28")
		
func get_random_element():
	var rand_num = int(round(rand_range(0, 7)))
	
	match rand_num:
		Main.WATER: return Main.WATER
		Main.FIRE: return Main.FIRE
		Main.ELECTRIC: return Main.ELECTRIC 
		Main.PLANT: return Main.PLANT 
		Main.WIND: return Main.WIND 
		Main.ROCK: return Main.ROCK 
		Main.GHOST: return Main.GHOST
		Main.GROUND: return Main.GROUND




