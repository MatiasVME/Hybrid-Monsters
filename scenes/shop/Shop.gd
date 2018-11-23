extends Node2D

var item_in_gui = preload("res://scenes/hud/inventory/Item.tscn")

func _ready():
	for item in DataManager.shop_inventory.get_inv():
		add_item_to_shop(item)
		
	for item in DataManager.inventories[Main.current_player].get_inv():
		add_item_to_inv(item)

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
	
func deselect_all_items_except(item_gui_except):
	for item_gui in get_tree().get_nodes_in_group("ItemGUI"):
		if item_gui != item_gui_except and item_gui.pressed:
			item_gui.pressed = false

func _on_item_toggled(button_pressed, item_gui):
#	remove_all_descriptions()
	
	if button_pressed:
		deselect_all_items_except(item_gui)
#		describe_commons(item_gui.hm_item)
#		describe_potion(item_gui.hm_item)
#		describe_usable(item_gui.hm_item)
#		describe_equipable(item_gui.hm_item)
#		describe_attack(item_gui.hm_item)
		# Por ahora no usar describe_sword, ya que el puro nombre 
		# describe el material y la forma
#		describe_sword(item_gui.hm_item)