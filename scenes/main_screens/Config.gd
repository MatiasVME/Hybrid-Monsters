extends Node2D

func _ready():
	pass

func _on_DeleteData_pressed():
	$AreYouSure.visible = true

func _on_AreYouSure_confirmed():
	DataManager.remove_all_data()
	get_tree().quit()
