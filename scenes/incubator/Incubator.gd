extends Node2D

var eggs = []

func _ready():
	EggFactory.create_egg(60*10)
	EggFactory.create_egg(60*20)
	EggFactory.create_egg(60*30)
	
	for i in EggFactory.eggs.size():
		add_item(EggFactory.eggs[i])
		eggs.append(EggFactory.eggs[i])
		
	EggFactory.get_delivery().connect("new_delivery", self, "_on_new_egg_opened")

func add_item(egg_data):
	var egg_slot = load("res://scenes/incubator/EggSlot.tscn").instance()
	egg_slot.add_egg(egg_data)
	$HBox/EggsSlots/Grid.add_child(egg_slot)
	
	egg_slot.connect("toggled", self, "_on_egg_slot_toggled", [egg_slot])

func deselect_all_slots_except(slot_gui_except):
	for egg_slot in get_tree().get_nodes_in_group("EggSlot"):
		if egg_slot != slot_gui_except and egg_slot.pressed:
			egg_slot.pressed = false

func _on_egg_slot_toggled(button_pressed, egg_slot):
	if button_pressed:
		deselect_all_slots_except(egg_slot)
		$Egg.update_with(egg_slot.egg_data)

func _on_new_egg_opened(delivery):
#	print(delivery)
	
#	if delivery[]
	
	# Test
	var rand_sound = int(round(rand_range(SoundManager.Sound.MAGICAL_1, SoundManager.Sound.MAGICAL_3)))
	SoundManager.play_sound(rand_sound)
	$Egg/Anim.play("open")
	
	