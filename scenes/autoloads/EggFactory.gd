extends Node

var eggs = []

func create_egg(time_to_open, force_step = 10):
	var egg = {}
	
	egg["Delivery"] = str(OS.get_unix_time() + eggs.size()) # id "unico"
	egg["TexturePath"] = get_random_egg_texture()
	egg["CrackLevel"] = 0
	
	egg["CrackPoints"] = []
	egg["CrackPoints"].append(0 + force_step * 10) # null | 0
	egg["CrackPoints"].append(time_to_open / 4) # crack-1.png | 1
	egg["CrackPoints"].append(time_to_open / 4 * 2) # crack-2.png | 2
	egg["CrackPoints"].append(time_to_open / 4 * 3) # crack-3.png | 3
	egg["CrackPoints"].append(time_to_open - force_step * 10) # crack-4.png | 4
	egg["Colors"] = []
	egg["Colors"].append(Main.get_random_color())
	egg["Colors"].append(Main.get_random_color())
	egg["Colors"].append(Main.get_random_color())
	
	eggs.append(egg)
	
	$EggDelivery.create_delivery(egg["Delivery"], time_to_open, force_step, true)
	
#	print(egg)
	
func get_random_egg_texture():
	var rand_num = int(round(rand_range(0, 4)))
	
	match rand_num:
		0: return "res://scenes/incubator/Eggs/egg_1.png"
		1: return "res://scenes/incubator/Eggs/egg_2.png"
		2: return "res://scenes/incubator/Eggs/egg_3.png"
		3: return "res://scenes/incubator/Eggs/egg_4.png"
		4: return "res://scenes/incubator/Eggs/egg_5.png"

func get_crack_level(egg):
	if not $EggDelivery.delivery_time(egg["Delivery"]):
		return
	
	var delivery = $EggDelivery.get_delivery(egg["Delivery"])
	var random_crunch = int(round(rand_range(SoundManager.Sound.CRUNCH_1, SoundManager.Sound.CRUNCH_3)))
	
#	print($EggDelivery.delivery_time(egg["Delivery"]))
#	print(egg["CrackLevel"])
	
	if $EggDelivery.delivery_time(egg["Delivery"]) <= egg["CrackPoints"][0] and egg["CrackLevel"] == 4:
		egg["CrackLevel"] += 1
		return egg["CrackLevel"]
	elif $EggDelivery.delivery_time(egg["Delivery"]) <= egg["CrackPoints"][1] and egg["CrackLevel"] == 3:
		egg["CrackLevel"] += 1
		SoundManager.play_sound(random_crunch)
		return egg["CrackLevel"]
	elif $EggDelivery.delivery_time(egg["Delivery"]) <= egg["CrackPoints"][2] and egg["CrackLevel"] == 2:
		egg["CrackLevel"] += 1
		SoundManager.play_sound(random_crunch)
		return egg["CrackLevel"]
	elif $EggDelivery.delivery_time(egg["Delivery"]) <= egg["CrackPoints"][3] and egg["CrackLevel"] == 1:
		egg["CrackLevel"] += 1
		SoundManager.play_sound(random_crunch)
		return egg["CrackLevel"]
	elif $EggDelivery.delivery_time(egg["Delivery"]) <= egg["CrackPoints"][4] and egg["CrackLevel"] == 0:
		egg["CrackLevel"] += 1
		SoundManager.play_sound(random_crunch)
		return egg["CrackLevel"]
	else:
		return egg["CrackLevel"]
		
func get_crack_texture(crack_level):
	match crack_level:
		0: return
		1: return "res://scenes/incubator/Cracks/crack-1.png"
		2: return "res://scenes/incubator/Cracks/crack-2.png"
		3: return "res://scenes/incubator/Cracks/crack-3.png"
		4: return "res://scenes/incubator/Cracks/crack-4.png"
		5: return "res://scenes/incubator/Cracks/crack-4.png"
	
func get_time_to_open(delivery_name):
	return $EggDelivery.str_delivery_time(delivery_name)
	
func force_step(delivery_name):
	$EggDelivery.force_step(delivery_name)
	
func get_delivery():
	return $EggDelivery
	