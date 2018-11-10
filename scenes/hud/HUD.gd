extends CanvasLayer

func _on_HUDInventory_toggled(button_pressed):
	if button_pressed:
		$AnimInv.play("show")
	else:
		$AnimInv.play("hide")

func _on_HUDMenuButton_pressed():
	$AnimMenu.play("show")

func _on_Resume_pressed():
	$AnimMenu.play("hide")

func _on_Menu_pressed():
	get_tree().change_scene("res://scenes/main_screens/MainMenu.tscn")
