extends Node2D

func _ready():
	$Front/Anim.play("delay_open")
	
	$Screens/MainMenu.connect("play", self, "_on_play")
	
func _on_play():
	$Anim.play("stop_music")
