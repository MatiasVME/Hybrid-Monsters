extends Node2D

signal play

func _ready():
	pass

func _on_Play_pressed():
	emit_signal("play")
	$Anim.play("play")
	
func _on_Anim_animation_finished(anim_name):
	if anim_name == "play":
#		DataManager.load_data_user("Pepito")	
		get_tree().change_scene("res://scenes/levels/Levels.tscn")
