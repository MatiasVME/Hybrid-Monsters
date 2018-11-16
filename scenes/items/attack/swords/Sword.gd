extends "../Attack.gd"

func _ready():
	pass

# Actualiza la data del sword, como por ejemplo el skin
func update():
	if item == null:
		print("No se puede actualizar ya que no hay item")
		return
	
	var material
	
	match item.material:
		item.Materials.WOOD:
			material = "wood"
		item.Materials.IRON:
			material = "iron"
		item.Materials.DIAMOND:
			material = "diamond"
		item.Materials.RUBY:
			material = "ruby"
			
	var form
	
	match item.form:
		item.Form.NORMAL:
			form = "normal"
		item.Form.JAGGED:
			form = "jagged"
		item.form.WIDE:
			form = "wide"
	
	var sword_texture = load("res://scenes/items/attack/swords/skins/", material, "-", form, ".png")
	$Sprite.texture = sword_texture