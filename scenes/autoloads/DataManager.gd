extends Node

# Se deja así para que pueda ser accedido de otras
# partes
onready var Persistence = $Persistence

var data

func _ready():
	load_data()
	
func save_data(folder = "Global", file = "Config"):
	Persistence.folder_name = folder
	Persistence.save_data(file)
	
func load_data(folder = "Global", file = "Config"):
	Persistence.folder_name = folder
	data = Persistence.get_data()
