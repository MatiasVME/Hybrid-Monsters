extends "../Attack.gd"

func _ready():
	update()
	var rand_sound = int(round(rand_range(SoundManager.SWORD_1, SoundManager.SWORD_3)))
	SoundManager.play_sound(rand_sound)

# Actualiza la data del sword, como por ejemplo el skin
func update():
	if item == null:
		print("No se puede actualizar ya que no hay item")
		return

	var sword_texture = load(item.texture_path)
	print(item.texture_path)
	$Sprite.texture = sword_texture