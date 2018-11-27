extends Node2D

func _ready():
	pass

func result():
	if Main.result == Main.WIN:
		$Title.text = "You Win!"
		$Stats/Grid/DE.text = str(
			Main.store_destroyed_enemies,
			"/",
			Main.total_enemies
		)
		$BonusDisplay.visible = false
		$Stats/Grid/GC.text = str(Main.store_gold)
		
		if Main.store_destroyed_enemies == Main.total_enemies:
			var bonus_gold = Main.store_gold * 50 / 100
			$Stats/Grid/GC.text = str(Main.store_gold, " + ", bonus_gold)
			Main.current_gold += bonus_gold
			
			$BonusDisplay.visible = true
			$BonusDisplay/Anim.play("idle")
		
		Main.increase_dificulty()
		$Resume.hide()
		$Next.show()
	elif Main.result == Main.LOST:
		$Title.text = "You Lost"
		$Stats/Grid/DE.text = str(
			Main.store_destroyed_enemies,
			"/",
			Main.total_enemies
		)
		
		$BonusDisplay.visible = false
		
		$Stats/Grid/GC.text = str(Main.store_gold)
		
		Main.diminish_dificulty()
		$Resume.show()
		$Next.hide()
	
	$Stats/Grid/XPC.text = str(Main.store_xp)
	
	DataManager.save_user_config()
	DataManager.save_players()

func _on_Menu_pressed():
	MusicManager.stop_music()
	Main.reset_store()
	get_tree().change_scene("res://scenes/Main.tscn")

func _on_Next_pressed():
	Main.reset_store()
	get_tree().change_scene("res://scenes/levels/Levels.tscn")

func _on_Resume_pressed():
	Main.reset_store()
	get_tree().change_scene("res://scenes/levels/Levels.tscn")