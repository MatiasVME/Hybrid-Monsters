extends Node2D

func _ready():
	pass

func result():
	if Main.result == Main.WIN:
		Main.increase_dificulty()
		$Resume.hide()
		$Next.show()
	elif Main.result == Main.LOST:
		Main.diminish_dificulty()
		$Resume.show()
		$Next.hide()
		
	DataManager.save_data_user(DataManager.current_user)

func _on_Menu_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")

func _on_Next_pressed():
	get_tree().change_scene("res://scenes/levels/Levels.tscn")

func _on_Resume_pressed():
	get_tree().change_scene("res://scenes/levels/Levels.tscn")
