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
		
	DataManager.save_user_config()
	DataManager.save_players()

func _on_Menu_pressed():
	MusicManager.stop_music()
	get_tree().change_scene("res://scenes/Main.tscn")

func _on_Next_pressed():
	get_tree().change_scene("res://scenes/levels/Levels.tscn")

func _on_Resume_pressed():
	get_tree().change_scene("res://scenes/levels/Levels.tscn")

func _on_Shop_toggled(button_pressed):
	if button_pressed:
		$Shop.update_gold_amount()
		$Shop.update_inv_items()
		$ShopAnim.play("show")
	else:
		$ShopAnim.play("hide")
