extends Node2D

func _ready():
	var rand_music = int(round(rand_range(MusicManager.Music.PARALLEL_WORLD, MusicManager.Music.NEVER_SEE_THE_SUN)))
	MusicManager.select_music(rand_music)
	MusicManager.play_music()
	
	$Camera.set_focus($World/Player)
	$Camera.current = true
	
	# Añadimos el hud al final para que actualice los datos
	$HUD.player = $World/Player
	$World/Player.set_hud($HUD)
	$HUD.initial_config()