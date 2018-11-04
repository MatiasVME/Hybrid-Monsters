extends Node

#enum Music {
#	INTRO
#}
#var current_music = null
#var current_pos = -1
#
#func _ready():
#	select_music(Music.INTRO)
#	play_music()
#
#func select_music(p_music):
#	if not Main.MUSIC_ENABLE:
#		return
#
#	if current_music != null:
#		current_music.stop()
#
#	current_pos = -1
#
#	if p_music == Music.INTRO:
#		current_music = intro
#
#
#func play_music():
#	if not Main.MUSIC_ENABLE:
#		return
#
#	if current_music != null:
#		if current_pos != -1:
#			current_music.play(current_pos)
#		else:
#			current_music.play()
#
#func stop_music():
#	if not Main.MUSIC_ENABLE:
#		return
#
#	if current_music != null:
#		current_pos = current_music.get_pos()
#		current_music.stop()
