extends Node2D

signal play

onready var menu_music = get_parent().get_parent().get_node("Underground")

func _ready():
	$Version.text = "v" + Main.VERSION

func _on_Play_pressed():
	emit_signal("play")
	$Anim.play("play")
	
func _on_Anim_animation_finished(anim_name):
	if anim_name == "play":
#		DataManager.load_data_user("Pepito")	
		get_tree().change_scene("res://scenes/levels/Levels.tscn")

func _on_Music_toggled(button_pressed):
	if button_pressed:
		menu_music.stop()
		Main.music_enable = false
	else:
		Main.music_enable = true
		menu_music.play()

func _on_Sound_toggled(button_pressed):
	if button_pressed:
		Main.sound_enable = false
	else:
		Main.sound_enable = true
	