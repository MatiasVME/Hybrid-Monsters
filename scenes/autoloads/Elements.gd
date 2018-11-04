extends Node

func get_color_element(color_element):
	match color_element:
		Main.WATER: return Color("0098dc")
		Main.FIRE: return Color("c42430")
		Main.ELECTRIC: return Color("ffc825")
