extends CanvasLayer

var player_data
# Al HUD se le debe pasar el player completo
var player # No borrar

func _ready():
	if DataManager.players.size() > 0:
		player_data = DataManager.players[Main.current_player].connect("dead", self, "_on_dead")
	
	$Debug/VarDificulty.text = str("var_dificulty: ", Main.var_dificulty)

	$Attributes.update()
	
func _input(event):
	if event.is_action_pressed("inventory"):
		$Inventory/HUDInventory.pressed = not $Inventory/HUDInventory.pressed
		_on_HUDInventory_toggled($Inventory/HUDInventory.pressed)
	elif event.is_action_pressed("attributes"):
		$HubOther.pressed = not $HubOther.pressed
		_on_HubOther_toggled($HubOther.pressed)
		$Inventory.update_stats()
	elif event.is_action_pressed("shop"):
		$ShopButton.pressed = not $ShopButton.pressed
		_on_ShopButton_toggled($ShopButton.pressed)
	elif event.is_action_pressed("ui_cancel"):
		$HUDMenuButton.pressed = not $HUDMenuButton.pressed
		_on_HUDMenuButton_toggled($HUDMenuButton.pressed)

func _on_HUDInventory_toggled(button_pressed):
	if button_pressed:
		$AnimInv.play("show")
	else:
		$AnimInv.play("hide")

#func _on_HUDMenuButton_pressed():
#	$AnimMenu.play("show")

func _on_Resume_pressed():
	$HUDMenuButton.pressed = false
	$AnimMenu.play("hide")

func _on_Menu_pressed():
	MusicManager.stop_music()
	get_tree().change_scene("res://scenes/Main.tscn")

func win():
	$WinLost/Title.text = "You Win!"
	$WinLost/Stats/Grid/DE.text = str(
		Main.store_destroyed_enemies,
		"/",
		Main.total_enemies
	)
	Main.result = Main.WIN
	$WinLost.result()
	$AnimWinLost.play("show")
	
func _on_dead():
	$WinLost/Title.text = "You Lost"
	$WinLost/Stats/Grid/DE.text = str(
		Main.store_destroyed_enemies,
		"/",
		Main.total_enemies
	)
	Main.result = Main.LOST
	$WinLost.result()
	$AnimWinLost.play("show")

func _on_HubOther_toggled(button_pressed):
	if button_pressed:
		$AnimAttributes.play("show")
	else:
		$AnimAttributes.play("hide")

func _on_ShopButton_toggled(button_pressed):
	if button_pressed:
		$Shop.update_gold_amount()
		$Shop.update_inv_items()
		$AnimShop.play("show")
	else:
		$AnimShop.play("hide")

func _on_HUDMenuButton_toggled(button_pressed):
	if button_pressed:
		$AnimMenu.play("show")
	else:
		$AnimMenu.play("hide")
