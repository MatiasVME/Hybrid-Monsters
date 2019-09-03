extends Node

# Al principio tendrá un solo usuario
var current_user = "Pepito"

var global_config # Es una referencia al diccionario de $GlobalConfig
var user_config # Es una referencia al diccionario de $UserConfig

var players = [] # Contiene instancias
var inventories = []
var stats = []

# Si este numero cambia la data se borra, normalmente el numero
# debe ir incrementando
var delete_data = 3

var shop_inventory

var inst_players = []

func _ready():
	configure_persistence_node()
	create_or_load_data_if_not_exist()

func configure_persistence_node():
	if Main.DEBUG_PERSISTENCE_NODE:
		$GlobalConfig.mode = $GlobalConfig.Mode.TEXT
		$Players.mode = $Players.Mode.TEXT
		$UserConfig.mode = $UserConfig.Mode.TEXT
		$Inventories.mode = $Inventories.Mode.TEXT
		$Stats.mode = $Stats.Mode.TEXT
	else:
		$GlobalConfig.mode = $GlobalConfig.Mode.ENCRYPTED
		$Players.mode = $Players.Mode.ENCRYPTED
		$UserConfig.mode = $UserConfig.Mode.ENCRYPTED
		$Inventories.mode = $Inventories.Mode.ENCRYPTED
		$Stats.mode = $Stats.Mode.ENCRYPTED
	
	$GlobalConfig.folder_name = "Global"
	
	$UserConfig.folder_name = current_user
	$Players.folder_name = current_user
	$Inventories.folder_name = current_user
	$Stats.folder_name = current_user

func create_or_load_data_if_not_exist():
	global_config = $GlobalConfig.get_data()
	
	if global_config.empty():
		# Crea la data
		#

		create_global_config()
		create_players()
		create_user_config()
		create_inventories()
		create_stats()
	elif global_config["DeleteData"] != delete_data:
		remove_all_data()
		get_tree().quit()
	else:
		# Carga la data
		#
		
		# GlobalConfig ya se cargo anteriormente.
		
		load_players()
		load_user_config()
		load_inventories()
		load_stats()

func save_all_data():
	save_players()
	save_user_config()
	save_inventories()
	save_stats()

func create_global_config():
	global_config["DeleteData"] = delete_data
	$GlobalConfig.save_data()
	
func create_players():
	var temp_data
	temp_data = $Players.get_data("Players")
	
	players.append(PlayerGenerator.generate_first_player())
	
	temp_data[0] = inst2dict(players[0])
	
	$Players.save_data("Players")
	
func save_players():
	var temp_data = $Players.get_data("Players")
	temp_data.clear()
	
	for i in players.size():
		temp_data[i] = inst2dict(players[i])
		
	$Players.save_data("Players")
	
func load_players():
	var temp_data = $Players.get_data("Players")
	players = []
	
	for player in temp_data.values():
		players.append(dict2inst(player))

func create_user_config():
	user_config = $UserConfig.get_data("UserConfig")
	
	DeliveryManager.get_node("Deliveries").create_delivery("ShopItems", 60 * 10)
#	DeliveryManager.get_node("Deliveries").create_delivery("ShopItems", 10)
	shop_inventory = $HMRPGHelper.get_inst_weight_inventory()
	ItemGenerator.create_item_pack_for_shop(shop_inventory)
	
	Main.init_basic_user_config()
#	AchievementsManager.create_all_achievements()
	
	save_user_config()

func load_user_config():
	user_config = $UserConfig.get_data("UserConfig")
	
	Main.dificulty_selected = user_config["Dificulty"]
	Main.var_dificulty = user_config["VarDificulty"]
	Main.map_size = user_config["MapSize"]
	Main.total_enemies = user_config["TotalEnemies"]
	Main.current_gold = user_config["Gold"]
	Main.current_emeralds = user_config["Emeralds"]
	Main.current_level = user_config["CurrentLevel"]
	DeliveryManager.get_node("Deliveries").deliveries = user_config["Deliveries"]
	
	var temp_inv = $HMRPGHelper.get_inst_weight_inventory()
	shop_inventory = temp_inv.dict2inv(user_config["ShopInventory"])
	
	AchievementsManager.get_node("HookAchievements").set_complete_achievements_array(user_config["AchievementsCompleted"])
	
func save_user_config():
	user_config["Dificulty"] = Main.dificulty_selected
	user_config["VarDificulty"] = Main.var_dificulty
	user_config["MapSize"] = Main.map_size
	user_config["TotalEnemies"] = Main.total_enemies
	user_config["Gold"] = Main.current_gold
	user_config["Emeralds"] = Main.current_emeralds
	user_config["CurrentLevel"] = Main.current_level
	user_config["Deliveries"] = DeliveryManager.get_node("Deliveries").deliveries
	user_config["ShopInventory"] = shop_inventory.inv2dict()
	user_config["AchievementsCompleted"] = AchievementsManager.get_node("HookAchievements").get_complete_achievements_array()
	
	$UserConfig.save_data("UserConfig")

func create_inventories():
	var w_inv = HMRPGHelper.get_inst_weight_inventory()
	w_inv.max_weight = 10
	w_inv.add_item(ItemGenerator.get_health_potion(HMHealth.TypePotion.TYPE_10))
	w_inv.add_item(ItemGenerator.get_health_potion(HMHealth.TypePotion.TYPE_10))
	w_inv.add_item(ItemGenerator.get_health_potion(HMHealth.TypePotion.TYPE_10))
	
#	w_inv.add_item(ItemGenerator.get_random_sword_from_enemy(20,20))
#	w_inv.add_item(ItemGenerator.get_random_sword_from_enemy(20,20))
#	w_inv.add_item(ItemGenerator.get_random_sword_from_enemy(20,20))
	
	inventories.append(w_inv)

	save_inventories()
	
func save_inventories():
	var temp_data = $Inventories.get_data("Inventories")
	temp_data.clear()
	
	for i in inventories.size():
		temp_data[i] = inventories[i].inv2dict()
	
	$Inventories.save_data("Inventories")
	
func load_inventories():
	var temp_data = $Inventories.get_data("Inventories")
	var temp_inv = $HMRPGHelper.get_inst_weight_inventory()
	inventories = []
	
	for inventory in temp_data.values():
		inventories.append(temp_inv.dict2inv(inventory))

func create_stats():
	var temp_data
	temp_data = $Stats.get_data("Stats")
	
	var first_stats = $HMRPGHelper.get_inst_stats()
	first_stats.add_stat("Strength", 0, 30)
	first_stats.add_stat("Luck", 0, 20)
	first_stats.add_stat("Vitality", 0, 30)
	
	stats.append(first_stats)
	
	temp_data[0] = inst2dict(stats[0])
	
	$Stats.save_data("Stats")
	
	# Test
#	stats[0].add_points(100)
	
func load_stats():
	var temp_data = $Stats.get_data("Stats")
	stats = []
	
	for stat in temp_data.values():
		stats.append(dict2inst(stat))
	
func save_stats():
	var temp_data = $Stats.get_data("Stats")
	temp_data.clear()
	
	for i in stats.size():
		temp_data[i] = inst2dict(stats[i])
		
	$Stats.save_data("Stats")
	
func remove_all_data():
	$GlobalConfig.remove_all_data()
	$Players.remove_all_data()
	$UserConfig.remove_all_data()
	$Inventories.remove_all_data()
	$Stats.remove_all_data()
