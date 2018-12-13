extends Node2D

func _ready():
	MusicManager.select_music(MusicManager.Music.PARALLEL_WORLD)
	MusicManager.play_music()
	
	$Camera.set_focus($World/Player)
	$Camera.current = true
	
	# Añadimos el hud al final para que actualice los datos
	$HUD.player = $World/Player
	$World/Player.set_hud($HUD)
	$HUD.initial_config()