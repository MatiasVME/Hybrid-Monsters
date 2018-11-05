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

var is_first_time = false