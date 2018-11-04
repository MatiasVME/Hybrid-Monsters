extends Node

enum Elements {
	WATER,
	FIRE,
	ELECTRIC,
	PLANT,
	WIND,
	ROCK,
	GHOST,
	GROUND
}

func get_color_element(color_element):
	match color_element:
		WATER: return Color("0098dc")
		FIRE: return Color("c42430")
		ELECTRIC: return Color("ffc825")
