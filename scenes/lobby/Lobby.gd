extends Node2D

func _ready():
	randomize()
	var music_num = int(round(rand_range(MusicManager.WAR, MusicManager.TUNINUNININU)))
	MusicManager.select_music(music_num)
	MusicManager.play_music()
	MusicManager.start_anim()
	
	$Camera.set_focus($World/Player)
	$Camera.current = true
	
	# Añadimos el hud al final para que actualice los datos
	$HUD.player = $World/Player
	$World/Player.set_hud($HUD)
	$HUD.get_node("Inventory").update_inv()