extends Node2D

signal play

onready var menu_music = get_parent().get_parent().get_node("Underground")

func _ready():
	$Version.text = "v" + Main.VERSION
	
	if not Main.music_enable:
		$Music.pressed = true
	if not Main.sound_enable:
		$Sound.pressed = true

func _on_Play_pressed():
	emit_signal("play")
	$Anim.play("play")
	
	SoundManager.play_sound(SoundManager.BUTTON_PRESSED)
	
func _on_Anim_animation_finished(anim_name):
	if anim_name == "play":
#		DataManager.load_data_user("Pepito")	
		get_tree().change_scene("res://scenes/lobby/Lobby.tscn")

func _on_Music_toggled(button_pressed):
	SoundManager.play_sound(SoundManager.BUTTON_PRESSED)
	
	if button_pressed:
		menu_music.stop()
		Main.music_enable = false
	else:
		Main.music_enable = true
		menu_music.play()

func _on_Sound_toggled(button_pressed):
	SoundManager.play_sound(SoundManager.BUTTON_PRESSED)
	
	if button_pressed:
		Main.sound_enable = false
	else:
		Main.sound_enable = true
	
func _on_Info_pressed():
	SoundManager.play_sound(SoundManager.BUTTON_PRESSED)

func _on_Config_pressed():
	SoundManager.play_sound(SoundManager.BUTTON_PRESSED)
