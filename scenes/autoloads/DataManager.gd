extends Node

# Se deja así para que pueda ser accedido de otras
# partes
onready var Persistence = $Persistence

# Al principio tendrá un solo usuario
var current_user = "Pepito"

# La data actual en un diccionario
var data = {}

var player_config

# La data instanciada del usuario seleccionado
var players = []
var inventories = []
var stats = []

func _ready():
	pass

# Carga todos los datos del usuario
func load_data_user(user):
	load_players(user, user)
	load_player_config(user)
	
# Cargar de diccionario en archivo a instancias
func load_players(folder, file):
	load_data(folder, file)
	
	if data.has("Players"):
		for i in data["Players"].size():
			players.append(dict2inst(data["Players"][i]))
	else:
		players.append(HMRPGHelper.get_hm_inst_character())
		save_players(folder, file)
	
func load_player_config(folder):
	Persistence.folder_name = folder
	player_config = Persistence.get_data("Config")
	
	if player_config.empty():
		Main.init_basic_player_config()
		save_player_config(folder)

func save_player_config(folder):
	Persistence.folder_name = folder
#	player_config = Persistence.get_data("Config")
	Persistence.save_data("Config")
	print("config: ", Persistence.get_data("Config"))

# Guardar las instancias a diccionario
func save_players(folder, file):
	data["Players"] = []
	
	for i in players.size():
		data["Players"].append(inst2dict(players[i]))
		
	save_data(folder, file)

func save_data(folder = "Global", file = "Config"):
	Persistence.folder_name = folder
	Persistence.save_data(file)
	
func load_data(folder = "Global", file = "Config"):
	Persistence.folder_name = folder
	data = Persistence.get_data(file)
