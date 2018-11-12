# Main.gd # Autoload

extends Node

const VERSION = "0.1.0"
const DEBUG = true

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
	PLAYER,
	ENEMY,
	OBJECT
}

var is_first_time = false

# Player con el cual se esta jugando actualmente
var current_player = 0

func init_game():
#	DataManager.players[0].restore_hp()
	if DataManager.players[0].is_dead:
		DataManager.players[0].revive()
	else:
		DataManager.players[0].restore_hp()
	
func exit_game():
	pass