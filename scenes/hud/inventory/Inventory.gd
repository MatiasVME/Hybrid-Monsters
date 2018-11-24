extends Node2D

var rec_item = preload("res://scenes/hud/inventory/Item.tscn")

onready var HUD = get_parent()

signal drop_item(item_dropped)

func update_inv():
	remove_all_inv_item()
	
	var inv = DataManager.inventories[0].get_inv()
	
	for item in inv:
		add_item(item)

func add_item(hm_item):
	var item_gui = rec_item.instance()
	item_gui.hm_item = hm_item
		
	$Inv/HBox/Items/Grid.add_child(item_gui)
	
	item_gui.update()
#	item_gui.get_node("Sprite").texture = load(hm_item.get_texture_path())
	
	item_gui.connect("toggled", self, "_on_item_toggled", [item_gui])
	
	if hm_item is Main.HMEquipable:
		# El item debe estar equipado?
		if hm_item.equiped_how != hm_item.Equipable.NONE:
			equip(hm_item)
	
	update_stats()
	
func deselect_all_items_except(item_gui_except):
	for item_gui in get_tree().get_nodes_in_group("ItemGUI"):
		if item_gui != item_gui_except and item_gui.pressed:
			item_gui.pressed = false
	
func describe_commons(hm_item):
	var commons = load("res://scenes/hud/inventory/ItemDesc-Commons.tscn").instance()
	commons.hm_item = hm_item
	commons.update()
	
	commons.get_node("Drop").connect("pressed", self, "_on_drop_equip", [hm_item])

	$Inv/HBox/ItemDesc/VBox.add_child(commons)

func describe_potion(hm_item):
	if not hm_item is Main.HMPotion:
		return
		
	var desc_potion = load("res://scenes/hud/inventory/ItemDesc-Potion.tscn").instance()
	desc_potion.hm_item = hm_item
	desc_potion.update()
		
	$Inv/HBox/ItemDesc/VBox.add_child(desc_potion)
	
func describe_usable(hm_item):
	if not hm_item is Main.HMUsable:
		return
	
	var desc_usable = load("res://scenes/hud/inventory/ItemDesc-Usable.tscn").instance()
	
	desc_usable.get_node("Use").connect("pressed", self, "_on_use_item", [hm_item])
	
	$Inv/HBox/ItemDesc/VBox.add_child(desc_usable)
	
func describe_equipable(hm_item):
	if not hm_item is Main.HMEquipable:
		return
		
	var equipable = load("res://scenes/hud/inventory/ItemDesc-Equipable.tscn").instance()
	
	# Si el item esta equipado dejar presionado el botón
	if hm_item.equiped_how != hm_item.Equipable.NONE:
		equipable.get_node("Equip").pressed = true
	
	equipable.get_node("Equip").connect("toggled", self, "_on_toggled_equip", [hm_item])
	
	$Inv/HBox/ItemDesc/VBox.add_child(equipable)

func describe_attack(hm_item):
	if not hm_item is Main.HMAttack:
		return
	
	var attack = load("res://scenes/hud/inventory/ItemDesc-Attack.tscn").instance()
	attack.hm_item = hm_item
	attack.update()
	
	$Inv/HBox/ItemDesc/VBox.add_child(attack)

func remove_all_descriptions():
	for desc in $Inv/HBox/ItemDesc/VBox.get_children():
		desc.queue_free()

func remove_all_inv_item():
	for item in $Inv/HBox/Items/Grid.get_children():
		$Inv/HBox/Items/Grid.remove_child(item)

func equip(hm_item):
	if hm_item is Main.HMSword:
		# Desequipar la anterior primary_weapon_data si es que existe
		if HUD.player.primary_weapon_data:
			HUD.player.primary_weapon_data.equiped_how = HUD.player.primary_weapon_data.Equipable.NONE
		
		HUD.player.get_node("CurrentWeapon").texture = load(hm_item.texture_path)
		HUD.player.primary_weapon_data = hm_item
		hm_item.equiped_how = HUD.player.primary_weapon_data.Equipable.PRIMARY_WEAPON
	
func unequip(hm_item):
	if hm_item is Main.HMSword:
		hm_item.equiped_how = HUD.player.primary_weapon_data.Equipable.NONE
		HUD.player.primary_weapon_data = null
		HUD.player.get_node("CurrentWeapon").texture = null

func describe_stats():
	var stats = load("res://scenes/hud/inventory/ItemDesc-Stats.tscn").instance()
	var player_data = DataManager.players[Main.current_player]
	var inventory_data = DataManager.inventories[Main.current_player]
	
	stats.get_node("Level").text = str("Level: ", player_data.level)
	stats.get_node("HP").text = str("HP: ", player_data.hp, "/", player_data.max_hp)
	stats.get_node("Energy").text = str("Energy: ", player_data.energy, "/", player_data.max_energy)
	stats.get_node("Weight").text = str("Weight: ", inventory_data.current_weight, "/", inventory_data.max_weight)
	
	$Inv/HBox/ItemDesc/VBox.add_child(stats)
	
func update_stats():
	remove_all_descriptions()
	describe_stats()

func _on_item_toggled(button_pressed, item_gui):
	remove_all_descriptions()
	
	if button_pressed:
		deselect_all_items_except(item_gui)
		describe_commons(item_gui.hm_item)
		describe_potion(item_gui.hm_item)
		describe_usable(item_gui.hm_item)
		describe_equipable(item_gui.hm_item)
		describe_attack(item_gui.hm_item)
		# Por ahora no usar describe_sword, ya que el puro nombre 
		# describe el material y la forma
#		describe_sword(item_gui.hm_item)
	else:
		describe_stats()

func _on_toggled_equip(button_pressed, hm_item):
	if button_pressed:
		equip(hm_item)
	elif not button_pressed:
		unequip(hm_item)

func _on_use_item(hm_item):
	if hm_item is Main.HMHealth:
		DataManager.players[Main.current_player].add_hp(hm_item.health)
		
	remove_all_descriptions()
	
	for item in get_node("Inv/HBox/Items/Grid").get_children():
		if item.hm_item == hm_item:
			get_node("Inv/HBox/Items/Grid").remove_child(item)
			break
			
	if hm_item is Main.HMHealth:
		HUD.get_node("Status").update_hp_progress()
		SoundManager.play_sound(SoundManager.BUBBLE)
	elif hm_item is Main.HMBook:
		hm_item.use()
		HUD.get_node("Attributes").update()
		SoundManager.play_sound(SoundManager.SPELL)
	
	DataManager.inventories[Main.current_player].delete_item(hm_item)
	
	update_stats()
	
	DataManager.save_inventories()

func _on_drop_equip(hm_item):
	var inv = DataManager.inventories[Main.current_player]
	
	var item_dropped = inv.take_item(hm_item)
	
	if item_dropped:
		for item in get_node("Inv/HBox/Items/Grid").get_children():
			if item.hm_item == item_dropped:
				if item.hm_item is Main.HMEquipable:
					if item_dropped.equiped_how != item_dropped.Equipable.NONE:
						unequip(item_dropped)
				remove_all_descriptions()
				get_node("Inv/HBox/Items/Grid").remove_child(item)
		
		SoundManager.play_sound(SoundManager.DROP)
		emit_signal("drop_item", item_dropped)
		
		DataManager.save_inventories()
	else:
		print("El item no pudo ser dropeado")
		
	update_stats()