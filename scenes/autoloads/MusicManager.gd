extends Node

enum Music {
	UNDERGROUND,
	WAR,
	SUNLESS,
	FLY,
	MARCH,
	TUNINUNININU
}
var current_music = null
var current_pos = -1

func select_music(p_music):
	if not Main.music_enable:
		return

	if current_music != null:
		current_music.stop()

	match p_music:
		Music.UNDERGROUND:
			current_music = $Underground
		Music.WAR:
			current_music = $War
		Music.SUNLESS:
			current_music = $Sunless
		Music.FLY:
			current_music = $Fly
		Music.MARCH:
			current_music = $March
		Music.TUNINUNININU:
			current_music = $TuNiNuNiNiNu

func play_music():
	if not Main.music_enable:
		return
	
	current_music.play()

func stop_music():
	if not Main.music_enable:
		return
	
	current_music.stop()