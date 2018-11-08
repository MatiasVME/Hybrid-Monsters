extends Node

# Se deja así para que pueda ser accedido de otras
# partes
onready var Persistence = $Persistence

# Al principio tendrá un solo usuario
var current_user = "Pepito"

# La data actual en un diccionario
var data = {}

# La data instanciada del usuario seleccionado
var players = []
var inventories = []
var stats = []

func _ready():
	pass

# Carga todos los datos del usuario
func load_data_user(user):
	load_players(user, user)
	
# Cargar de diccionario en archivo a instancias
func load_players(folder, file):
	load_data(folder, file)
	
	if data.has("Players"):
		for i in players.size():
			players.append(dict2inst(Main.data["Players"][i]))
		print("=o, player cargado")
	else:
		players.append(HMRPGHelper.get_hm_inst_character())
	
#	print("pepito: ", data)
#	save_players(folder, file)

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
