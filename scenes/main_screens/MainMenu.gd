extends Node2D

func _ready():
	pass

func _on_Play_pressed():
	DataManager.load_data_user("Pepito")
	
#	print(DataManager.players[0])
	print("DataManager.data: ", DataManager.data)
	
	get_tree().change_scene("res://tests/TMapProcedural.tscn")
