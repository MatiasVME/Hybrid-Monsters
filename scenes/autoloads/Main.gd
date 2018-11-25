# Main.gd # Autoload

extends Node

const VERSION = "0.2.0"
const DEBUG = true

var music_enable = true
var sound_enable = true

const RES_X = 240
const RES_Y = 160

# Clases
#

var HMAttack = preload("res://scenes/autoloads/rpg_elements_adaptation/item/equipable/attack/HMAttack.gd")
var HMEquipable = preload("res://scenes/autoloads/rpg_elements_adaptation/item/equipable/HMEquipable.gd")
var HMSword = preload("res://scenes/autoloads/rpg_elements_adaptation/item/equipable/attack/sword/HMSword.gd")
var HMPotion = preload("res://scenes/autoloads/rpg_elements_adaptation/item/usable/potion/HMPotion.gd")
var HMUsable = preload("res://scenes/autoloads/rpg_elements_adaptation/item/usable/HMUsable.gd")
var HMHealth = preload("res://scenes/autoloads/rpg_elements_adaptation/item/usable/potion/HMHealth.gd")
var HMBook = preload("res://scenes/autoloads/rpg_elements_adaptation/item/usable/book/HMBook.gd")

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
	PLAYER,
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

# Player con el cual se esta jugando actualmente
var current_player = 0

# Store: Lugar donde se almacena variables de juego de forma
#  temporal

# Guardado temporal de estadísticas del nivel
var store_destroyed_enemies = 0
var store_gold = 0
var store_xp = 0

func init_game():
	store_destroyed_enemies = 0
	
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

func diminish_dificulty():
	var_dificulty = clamp(var_dificulty - 0.2, 1, 10)
	map_size = clamp(map_size - 4, 20, 250)
	total_enemies = clamp(total_enemies - 4, 6, 100)

# Setters/Getters
#

func set_current_gold(_gold):
	current_gold = _gold
	emit_signal("gold_changed", current_gold)
	
func get_current_gold():
	return current_gold
