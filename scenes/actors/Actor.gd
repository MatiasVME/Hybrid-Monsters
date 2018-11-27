extends KinematicBody2D

onready var Grid = get_parent()

var rec_damage_num = preload("res://scenes/effects/damage_num/DamageNum.tscn")

signal move
signal attack
signal spawn

var primary_weapon
var primary_weapon_data
var secondary_weapon
var secondary_weapon_data
var armor
var armor_data

# Debe de ser un Main.CellType
var type = Main.PLAYER

var directions = [
	Vector2(-1, 0),
#	Vector2(-1, -1),
	Vector2(0, -1),
#	Vector2(1, -1), 
	Vector2(1, 0), 
#	Vector2(1, 1), 
	Vector2(0, 1) 
#	Vector2(-1, 1)
]

var is_mark_to_dead = false

func _ready():
	$CurrentWeapon.texture = null
	$CurrentArmor.texture = null
	$CurrentArtifact.texture = null

func spawn():
	emit_signal("spawn")
	
	$Anim.play("spawn")

func attack():
	emit_signal("attack")

func move_to(target_position):
	emit_signal("move")
	
	set_process(false)
	$Anim.play("walk")

	# Move the node to the target cell instantly,
	# and animate the sprite moving from the start to the target cell
	var move_direction = (target_position - position).normalized()
	$Tween.interpolate_property(
		$Pivot,
		"position", 
		-move_direction * 16, 
		Vector2(), 
		$Anim.current_animation_length, 
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN
	)
	position = target_position

	$Tween.start()

	# Stop the function execution until the animation finished
	yield($Anim, "animation_finished")
	
	set_process(true)

func bump():
	set_process(false)
	$Anim.play("bump")
	SoundManager.play_sound(SoundManager.NOPE)
	yield($Anim, "animation_finished")
	set_process(true)
	
func get_rand_posible_dir():
	var rand_pos
	var posible_dir = get_posible_dir()
	
	if posible_dir != null:
		rand_pos = randi() % posible_dir.size()
		return posible_dir[rand_pos]
	
func get_posible_dir():
	var pos_in_map = Grid.world_to_map(global_position)
	var posible_directions = []
	
	for dir in directions:
		var new_pos = pos_in_map
		new_pos.x += dir.x
		new_pos.y += dir.y
		
		if Grid.get_cellv(new_pos) == -1:
			posible_directions.append(dir)
	
	if posible_directions.size() > 0:
		return posible_directions
