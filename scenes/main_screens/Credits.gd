extends Node2D

func _on_Credits_meta_clicked(meta):
	SoundManager.play_sound(SoundManager.BUTTON_PRESSED)
	OS.shell_open(meta)

