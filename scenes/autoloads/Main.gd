# Main.gd # Autoload

extends Node

const VERSION = "0.4.0"
const DEBUG = true

var music_enable = true
var sound_enable = true

const RES_X = 240
const RES_Y = 160

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

const SKIN_PLAYER_AMOUNT = 8
const SKIN_NORMAL_ENEMY_AMOUNT = 7

enum CellTypes {
	EMPTY = -1,
	FLOOR,
	WALL,
	INDESTRUCTIBLE_WALL,
	CAVE,
	PLAYER = 1000,
	ENEMY,
	OBJECT
}

var is_first_time = false

# Money = gold
var current_gold = 0 setget set_current_gold, get_current_gold
# Emerald igual money + op
var current_emeralds = 0 # setget # TODO

signal gold_changed(current_gold)
signal emeralds_changed

# Información del nivel
#

# Dificultad que varía dependiendo de las veces que ha ganado
# las veces que a perdido y la dificultad seleccionada por el
# jugador
var var_dificulty = 1.0

enum Dificulty {
	EASY,
	NORMAL,
	HARD
}
var dificulty_selected = Dificulty.NORMAL

enum Result {WIN, LOST}
var result

var map_size = 36
var total_enemies = 6
var enemies_required = 0

var current_level = 1

# Player con el cual se esta jugando actualmente
var current_player = 0

# Store: Lugar donde se almacena variables de juego de forma
#  temporal

# Guardado temporal de estadísticas del nivel
var store_destroyed_enemies = 0
var store_gold = 0
var store_xp = 0

# Localización de donde esta el spawn
var spawn_location = Vector2()
var arrow_active = false

func _ready():
	get_tree().set_auto_accept_quit(false)
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		DataManager.save_all_data()
		
		change_gdc2gd()
		
		get_tree().quit()

func change_gdc2gd():
	pass

func init_game():
	reset_store()
	arrow_active = false
	
	if DataManager.players[0].is_dead:
		DataManager.players[0].revive()
	else:
		DataManager.players[0].restore_hp()
	
func exit_game():
	pass

func reset_store():
	store_destroyed_enemies = 0
	store_gold = 0
	store_xp = 0

func init_basic_user_config():
	var_dificulty = 1.0
	
	match dificulty_selected:
		Dificulty.NORMAL: var_dificulty += 0.2
		Dificulty.HARD: var_dificulty += 0.4
	
	var_dificulty += DataManager.players[0].get_level() / 4
	
	DataManager.save_user_config()

func increase_dificulty():
	var_dificulty = clamp(var_dificulty + 0.2, 1, 10)
	map_size = clamp(map_size + 4, 20, 250)
	total_enemies = clamp(total_enemies + 4, 6, 100)
	current_level = clamp(current_level + 1, 0, 100)

func diminish_dificulty():
	var_dificulty = clamp(var_dificulty - 0.2, 1, 10)
	map_size = clamp(map_size - 4, 20, 250)
	total_enemies = clamp(total_enemies - 4, 6, 100)
	current_level = clamp(current_level - 1, 0, 100)

# Setters/Getters
#

func set_current_gold(_gold):
	current_gold = _gold
	emit_signal("gold_changed", current_gold)
	
func get_current_gold():
	return current_gold

func get_random_color():
	var rand_num = int(round(rand_range(0, 15)))
	
	match rand_num:
		0: return Color("5d5d5d")
		1: return Color("657392")
		2: return Color("ff0040")
		3: return Color("bf6f4a")
		4: return Color("e07438")
		5: return Color("ffeb57")
		6: return Color("ffc825")
		7: return Color("5ac54f")
		8: return Color("0069aa")
		9: return Color("00cdf9")
		10: return Color("f389f5")
		11: return Color("3003d9")
		12: return Color("93388f")
		13: return Color("ca52c9")
		14: return Color("ea323c")
		15: return Color("1e6f50")