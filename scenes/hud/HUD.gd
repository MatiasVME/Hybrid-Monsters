extends CanvasLayer

var player_data

func _ready():
	if DataManager.players.size() > 0:
		player_data = DataManager.players[0].connect("dead", self, "_on_dead")
	
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