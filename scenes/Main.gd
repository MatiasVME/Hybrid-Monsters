extends Node2D

func _ready():
	$Camera/Front/Anim.play("delay_open")
	
	$Screens/MainMenu.connect("play", self, "_on_play")
	
	if not Main.music_enable:
		$Underground.stop()
	
func _on_play():
	$Anim.play("stop_music")

func _on_Config_pressed():
	$ScreensAnim.play("menu2config")

func _on_Back_pressed():
	SoundManager.play_sound(SoundManager.Sound.BUTTON_PRESSED)
	$ScreensAnim.play("config2menu")

func _on_Info_pressed():
	$ScreensAnim.play("menu2credits")

func _on_BackCredits_pressed():
	SoundManager.play_sound(SoundManager.Sound.BUTTON_PRESSED)
	$ScreensAnim.play("credits2menu")
