#extends SamplePlayer2D
#
#enum Sound {
#	SOMETHING
#}
#var current_sound = ""
#
#func select_sound(p_sound):
#	if not Main.SOUND_ENABLE:
#		return
#
#	current_sound = ""
#
#	if p_sound == Sound.ADD_STAT:
#		current_sound = "AddStat"
#
#func play_sound():
#	if not Main.SOUND_ENABLE:
#		return
#
#	if current_sound != "":
#		play(current_sound)