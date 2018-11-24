extends Node2D

var item_in_gui = preload("res://scenes/hud/inventory/Item.tscn")
var current_item_in_gui

onready var hud = get_parent()

func _ready():
	add_shop_items()
	add_inv_items()
	
	DeliveryManager.connect("new_delivery", self, "_on_new_delivery")
	
	update_gold_amount()
	update_weight()

func update_gold_amount():
	$GoldAmount.text = str(Main.current_gold)

func update_weight():
	$Weight.text = str("Weight: ", DataManager.inventories[Main.current_player].current_weight)

func add_inv_items():
	for item in DataManager.inventories[Main.current_player].get_inv():
		add_item_to_inv(item)

func add_shop_items():
	for item in DataManager.shop_inventory.get_inv():
		add_item_to_shop(item)

func update_inv_items():
	remove_all_inv_item()
	add_inv_items()

func add_item_to_shop(hm_item):
	var item_gui = item_in_gui.instance()
	item_gui.hm_item = hm_item
		
	$Hbox/VBox/ShopItems/Grid.add_child(item_gui)
	
	item_gui.update()
	item_gui.connect("toggled", self, "_on_item_toggled", [item_gui])

func add_item_to_inv(hm_item):
	var item_gui = item_in_gui.instance()
	item_gui.hm_item = hm_item
		
	$Hbox/VBox/InvItem/Grid.add_child(item_gui)
	
	item_gui.update()
	item_gui.connect("toggled", self, "_on_item_toggled", [item_gui])

func remove_all_shop_items():
	for item in $Hbox/VBox/ShopItems/Grid.get_children():
		$Hbox/VBox/ShopItems/Grid.remove_child(item)

func remove_all_inv_item():
	for item in $Hbox/VBox/InvItem/Grid.get_children():
		$Hbox/VBox/InvItem/Grid.remove_child(item)

func deselect_all_items_except(item_gui_except):
	for item_gui in get_tree().get_nodes_in_group("ItemGUI"):
		if item_gui != item_gui_except and item_gui.pressed:
			item_gui.pressed = false

func remove_all_descriptions():
	for desc in $Hbox/Desc/VBox.get_children():
		desc.queue_free()

func describe_commons(hm_item):
	var commons = load("res://scenes/hud/inventory/ItemDesc-Commons.tscn").instance()
	commons.hm_item = hm_item
	commons.update()
	commons.hide_drop()
	
	$Hbox/Desc/VBox.add_child(commons)

func describe_potion(hm_item):
	if not hm_item is Main.HMPotion:
		return
		
	var desc_potion = load("res://scenes/hud/inventory/ItemDesc-Potion.tscn").instance()
	desc_potion.hm_item = hm_item
	desc_potion.update()
		
	$Hbox/Desc/VBox.add_child(desc_potion)

func describe_attack(hm_item):
	if not hm_item is Main.HMAttack:
		return
	
	var attack = load("res://scenes/hud/inventory/ItemDesc-Attack.tscn").instance()
	attack.hm_item = hm_item
	attack.update()
	
	$Hbox/Desc/VBox.add_child(attack)

func is_shop_item(hm_item):
	if DataManager.shop_inventory.get_inv().has(hm_item):
		return true
	return false

func can_buy_item(hm_item):
	# Verificar si se puede comprar
	if hm_item.buy_price <= Main.current_gold:
		return true
	return false

func unequip(hm_item):
	# Obtener el player
	var players = get_tree().get_nodes_in_group("Player")
	
	if players.size() > 0:
		if hm_item is Main.HMSword:
			hm_item.equiped_how = players[0].primary_weapon_data.Equipable.NONE
			players[0].primary_weapon_data = null
			players[0].get_node("CurrentWeapon").texture = null
			print("desiquepado supuestamente")
	else:
		print("no desiquipado")
		return
		
func _on_item_toggled(button_pressed, item_gui):
	remove_all_descriptions()
	current_item_in_gui = null
	
	if button_pressed:
		current_item_in_gui = item_gui
		
		deselect_all_items_except(item_gui)
		describe_commons(item_gui.hm_item)
		describe_potion(item_gui.hm_item)
		describe_attack(item_gui.hm_item)
		
		if is_shop_item(item_gui.hm_item) and can_buy_item(item_gui.hm_item):
			$Hbox/VBox/Buttons/Sell.disabled = true
			$Hbox/VBox/Buttons/Buy.disabled = false
		elif is_shop_item(item_gui.hm_item) and not can_buy_item(item_gui.hm_item):
			$Hbox/VBox/Buttons/Sell.disabled = true
			$Hbox/VBox/Buttons/Buy.disabled = true
		else:
			$Hbox/VBox/Buttons/Sell.disabled = false
			$Hbox/VBox/Buttons/Buy.disabled = true
	else:
		$Hbox/VBox/Buttons/Sell.disabled = true
		$Hbox/VBox/Buttons/Buy.disabled = true
	
func _on_new_delivery(delivery):
	if delivery[0] == "ShopItems":
		remove_all_shop_items()
		add_shop_items()
		remove_all_descriptions()
		
		$Hbox/VBox/Buttons/Buy.disabled = true
		$Hbox/VBox/Buttons/Sell.disabled = true

func _on_Buy_pressed():
	Main.current_gold -= current_item_in_gui.hm_item.buy_price

	# Pregunta si puede añadir el item dependiendo de su peso
	if not DataManager.inventories[Main.current_player].can_add_item(current_item_in_gui.hm_item):
		SoundManager.play_sound(SoundManager.NOPE)
		return

	# Moverlo al inventario visual del jugador
	$Hbox/VBox/ShopItems/Grid.remove_child(current_item_in_gui)
	$Hbox/VBox/InvItem/Grid.add_child(current_item_in_gui)
	
	# Moverlo desde shop_inventory a player_inventory
	var item_taken = DataManager.shop_inventory.take_item(current_item_in_gui.hm_item)
	DataManager.inventories[Main.current_player].add_item(item_taken)
	
	# Guardar
	DataManager.save_user_config()
	DataManager.save_inventories()
	
	# Actualizar label de oro
	update_gold_amount()
	update_weight()
	
	var rand_sound = int(round(rand_range(SoundManager.COIN_1, SoundManager.COIN_3)))
	SoundManager.play_sound(rand_sound)
	
	hud.get_node("Inventory").update_inv()
	
	$Hbox/VBox/Buttons/Sell.disabled = true
	$Hbox/VBox/Buttons/Buy.disabled = true
	deselect_all_items_except(null)

func _on_Sell_pressed():
	Main.current_gold += current_item_in_gui.hm_item.sell_price
	
	# Si esta equipado lo desequipamos
	if current_item_in_gui.hm_item is Main.HMEquipable and current_item_in_gui.hm_item.equiped_how != current_item_in_gui.hm_item.Equipable.NONE:
		print("Lo desequipamos")
		unequip(current_item_in_gui.hm_item)
	
	# Moverlo a la shop visual
	$Hbox/VBox/InvItem/Grid.remove_child(current_item_in_gui)
	$Hbox/VBox/ShopItems/Grid.add_child(current_item_in_gui)
	
	# Moverlo desde player_inventory al shop inventoy
	var item_taken = DataManager.inventories[Main.current_player].take_item(current_item_in_gui.hm_item)
	DataManager.shop_inventory.add_item(item_taken)
	
	# Guardar
	DataManager.save_user_config()
	DataManager.save_inventories()
	
	# Actualizar label de oro
	update_gold_amount()
	update_weight()
	
	var rand_sound = int(round(rand_range(SoundManager.COIN_1, SoundManager.COIN_3)))
	SoundManager.play_sound(rand_sound)
	
	hud.get_node("Inventory").update_inv()

	$Hbox/VBox/Buttons/Sell.disabled = true
	$Hbox/VBox/Buttons/Buy.disabled = true
	deselect_all_items_except(null)