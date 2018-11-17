extends Node2D

# Clases
#

var HMAttack = preload("res://scenes/autoloads/rpg_elements_adaptation/item/equipable/attack/HMAttack.gd")
var HMEquipable = preload("res://scenes/autoloads/rpg_elements_adaptation/item/equipable/HMEquipable.gd")
var HMSword = preload("res://scenes/autoloads/rpg_elements_adaptation/item/equipable/attack/sword/HMSword.gd")

var rec_item = preload("res://scenes/hud/inventory/Item.tscn")

func _ready():
	var inv = DataManager.inventories[0].get_inv()
	
	for item in inv:
		add_item(item)

func add_item(hm_item):
	var item_gui = rec_item.instance()
	item_gui.hm_item = hm_item

	$Inv/HBox/Items/VBox.add_child(item_gui)
	
	item_gui.get_node("Button").text = hm_item.item_name
	item_gui.get_node("Image").texture = load(hm_item.get_texture_path())
	
	item_gui.get_node("Button").connect("toggled", self, "_on_item_toggled", [item_gui])
	
func deselect_all_items_except(item_gui_except):
	for item_gui in get_tree().get_nodes_in_group("ItemGUI"):
		if item_gui != item_gui_except and item_gui.get_node("Button").pressed:
			item_gui.get_node("Button").pressed = false
	
func describe_commons(hm_item):
	var commons = load("res://scenes/hud/inventory/ItemDesc-Commons.tscn").instance()
	
	commons.get_node("Name").text = hm_item.item_name
	commons.get_node("Type").text = str("<", hm_item.item_type, ">")
	commons.get_node("Weight").text = str("Weight: ", hm_item.weight)
	commons.get_node("BuyPrice").text = str("Buy Price: ", hm_item.buy_price)
	commons.get_node("SellPrice").text = str("Sell Price: ", hm_item.sell_price)

	$Inv/HBox/ItemDesc/VBox.add_child(commons)

func describe_equipable(hm_item):
	if not hm_item is HMEquipable:
		return
		
	var equipable = load("res://scenes/hud/inventory/ItemDesc-Equipable.tscn").instance()
	
	$Inv/HBox/ItemDesc/VBox.add_child(equipable)

func describe_attack(hm_item):
	if not hm_item is HMAttack:
		return
	
	var attack = load("res://scenes/hud/inventory/ItemDesc-Attack.tscn").instance()
	
	attack.get_node("Damage").text = str("Damage: ", hm_item.damage)
	attack.get_node("PrimaryE").text = str("Primary Element: ", hm_item.primary_element_name)
	attack.get_node("SecundaryE").text = str("Secundary Element: ", hm_item.secundary_element_name)
	
	$Inv/HBox/ItemDesc/VBox.add_child(attack)

func remove_all_descriptions():
	for desc in $Inv/HBox/ItemDesc/VBox.get_children():
		desc.queue_free()

func _on_item_toggled(button_pressed, item_gui):
	remove_all_descriptions()
	
	if button_pressed:
		deselect_all_items_except(item_gui)
		describe_commons(item_gui.hm_item)
		describe_equipable(item_gui.hm_item)
		describe_attack(item_gui.hm_item)
		# Por ahora no usar describe_sword, ya que el puro nombre 
		# describe el material y la forma
#		describe_sword(item_gui.hm_item)
	