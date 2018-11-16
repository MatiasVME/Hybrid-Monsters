extends Node

# Al principio tendrá un solo usuario
var current_user = "Pepito"

var global_config # Es una referencia al diccionario de $GlobalConfig
var user_config # Es una referencia al diccionario de $UserConfig

var players = [] # Contiene instancias
var inventories
var stats

var inst_players = []

func _ready():
	configure_persistence_node()
	create_data_if_not_exist()

func configure_persistence_node():
	$GlobalConfig.folder_name = "Global"
	
	$UserConfig.folder_name = current_user
	$Players.folder_name = current_user
	$Inventories.folder_name = current_user
	$Stats.folder_name = current_user

func create_data_if_not_exist():
	global_config = $GlobalConfig.get_data()
	
	if global_config.empty():
		# Crea la data
		#

		create_global_config()
		create_players()
		create_user_config()
	else:
		# Carga la data
		#
		
		load_players()
		load_user_config()
	
func create_global_config():
	global_config["DeleteData"] = 0 
	$GlobalConfig.save_data()
	
func create_user_config():
	user_config = $UserConfig.get_data("UserConfig")
	
	Main.init_basic_user_config()
	
	save_user_config()

func create_players():
	var temp_data
	temp_data = $Players.get_data("Players")
	
	players.append(PlayerGenerator.generate_first_player())
	
	temp_data[0] = inst2dict(players[0])
	
	$Players.save_data("Players")
	
func save_players():
	var temp_data = $Players.get_data("Players")
	temp_data.clear()
	
	for i in players.size():
		temp_data[i] = inst2dict(players[i])
		
	$Players.save_data("Players")
	
func load_players():
	var temp_data = $Players.get_data("Players")
	players = []
	print(temp_data)
	
	for player in temp_data.values():
		players.append(dict2inst(player))

func load_user_config():
	user_config = $UserConfig.get_data("UserConfig")
	
	Main.dificulty_selected = user_config["Dificulty"]
	Main.var_dificulty = user_config["VarDificulty"]
	Main.map_size = user_config["MapSize"]
	Main.total_enemies = user_config["TotalEnemies"]
#	Main. = user_config["TotalEnemies"]
	
func save_user_config():
	user_config["Dificulty"] = Main.dificulty_selected
	user_config["VarDificulty"] = Main.var_dificulty
	user_config["MapSize"] = Main.map_size
	user_config["TotalEnemies"] = Main.total_enemies
	
	$UserConfig.save_data("UserConfig")
	
func remove_all_data():
	$GlobalConfig.remove_all_data()
	$Players.remove_all_data()
	$UserConfig.remove_all_data()
	$Inventories.remove_all_data()
	$Stats.remove_all_data()
