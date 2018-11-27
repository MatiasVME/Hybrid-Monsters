extends CanvasLayer

var player_data
# Al HUD se le debe pasar el player completo
var player # No borrar

func _ready():
	if DataManager.players.size() > 0:
		player_data = DataManager.players[Main.current_player].connect("dead", self, "_on_dead")
	
	$Debug/VarDificulty.text = str("var_dificulty: ", Main.var_dificulty)

	$Attributes.update()
	available_attributes()
	$Display.text = str("Level ", Main.current_level)

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

func connect_enemies():
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.connect("dead", self, "_on_enemy_dead")

func update_enemies_amount():
	$EnemiesAmount.text = str(
		"Enemies: ", 
		Main.store_destroyed_enemies, 
		"/", 
		Main.total_enemies
	)

func update_enemies_required():
	$EnemiesRequired.text = str("Required: ", Main.enemies_required)

func available_attributes():
	if DataManager.stats[Main.current_player].get_points() > 0:
		$AvailableAttributes.play("idle")
	else:
		$AvailableAttributes.stop()
		$HubOther.self_modulate = Color("ffffff")

func _on_HUDInventory_toggled(button_pressed):
	SoundManager.play_sound(SoundManager.BUTTON_PRESSED)
	
	if button_pressed:
		$AnimInv.play("show")
	else:
		$AnimInv.play("hide")

func _on_Resume_pressed():
	SoundManager.play_sound(SoundManager.BUTTON_PRESSED)
	
	$HUDMenuButton.pressed = false
	$AnimMenu.play("hide")

func _on_Menu_pressed():
	SoundManager.play_sound(SoundManager.BUTTON_PRESSED)
	
	MusicManager.stop_music()
	get_tree().change_scene("res://scenes/Main.tscn")

func win():
	Main.result = Main.WIN
	$WinLost.result()
	$AnimWinLost.play("show")
	
func _on_dead():
	Main.result = Main.LOST
	$WinLost.result()
	$AnimWinLost.play("show")
	
func _on_enemy_dead():
	update_enemies_amount()
	
	if Main.enemies_required == Main.store_destroyed_enemies:
		$Display.text = str("Spawn Cave")
		$Display/Anim.play("show")
	elif Main.store_destroyed_enemies == Main.total_enemies:
		$Display.text = str("All Enemies Killed")
		$Display/Anim.play("show")

func _on_HubOther_toggled(button_pressed):
	SoundManager.play_sound(SoundManager.BUTTON_PRESSED)
	
	if button_pressed:
		$AnimAttributes.play("show")
	else:
		$AnimAttributes.play("hide")

func _on_ShopButton_toggled(button_pressed):
	SoundManager.play_sound(SoundManager.BUTTON_PRESSED)
	
	if button_pressed:
		$Shop.update_gold_amount()
		$Shop.update_weight()
		$Shop.update_inv_items()
		$AnimShop.play("show")
	else:
		$AnimShop.play("hide")

func _on_HUDMenuButton_toggled(button_pressed):
	SoundManager.play_sound(SoundManager.BUTTON_PRESSED)
	
	if button_pressed:
		$AnimMenu.play("show")
	else:
		$AnimMenu.play("hide")
