# DeliveryManager.gd

extends Node

var deliveries = []

signal new_delivery(delivery)

func _ready():
	# Test
	create_delivery("Pizza", 10)
	connect("new_delivery", self, "_on_new_delivery")

func create_delivery(delivery_name, time_to_finalize, force_step=0):
	var last_time_delivery = OS.get_unix_time()
	deliveries.append([delivery_name, time_to_finalize, force_step, last_time_delivery])

# Devuelve true si ya ha pasado el tiempo del delivery
func is_delivery_have_passed(delivery_name):
	# Obtener el delivery dependiendo del nombre
	var delivery = get_delivery(delivery_name)
	
	if not delivery:
		print("No existe el delivery: ", delivery_name)
		return false
	
	var current_time = OS.get_unix_time()
	
	# last_time_delivery + time_tofinalize
	if current_time >= delivery[3] + delivery[1]:
		return true
	
	return false
	
# Devuelve el tiempo restante en segundos que queda para
# un nuevo delivery
func delivery_time(delivery_name):
	# Obtener el delivery dependiendo del nombre
	var delivery = get_delivery(delivery_name)
	
	# time_to_finalize + last_time_delivery - current_time
	return delivery[1] + delivery[3] - OS.get_unix_time()
	
# Reinicia el tiempo de entrega del shop delivery a el tiempo
# actual
func reset_delivery_time(delivery_name):
	# Obtener el delivery dependiendo del nombre
	var delivery = get_delivery(delivery_name)
	
	var current_time = OS.get_unix_time()
	delivery[3] = current_time

func get_delivery(delivery_name):
	for deli in deliveries:
		if deli.has(delivery_name):
			return deli

func _on_Timer_timeout():
	for deli in deliveries:
		print(delivery_time(deli[0]))
		
		if is_delivery_have_passed(deli[0]):
			reset_delivery_time(deli[0])
			emit_signal("new_delivery", deli)
			
func _on_new_delivery(delivery):
	print("Wiii pizza!!: ", delivery)
