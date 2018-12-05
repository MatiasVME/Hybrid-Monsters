extends Node2D

var hm_item
var can_take = false

var HUD

func _input(event):
	if can_take and event.is_action_pressed("ui_accept"):
		if not DataManager.inventories[0].can_add_item(hm_item):
			SoundManager.play_sound(SoundManager.NOPE)
			return
		
		if $Anim.current_animation != "take":
			SoundManager.play_sound(SoundManager.TAKE_ITEM)
			$Anim.play("take")
			DataManager.inventories[Main.current_player].add_item(hm_item)
			HUD.get_node("Inventory").add_item(hm_item)
			DataManager.save_inventories()
			
			if hm_item is Main.HMSword:
				if hm_item.material == hm_item.Materials.WOOD:
					AchievementsManager.complete_achievement_if_can(AchievementsManager.WOOD_AGE)
				elif hm_item.material == hm_item.Materials.IRON:
					AchievementsManager.complete_achievement_if_can(AchievementsManager.IRON_AGE)
				elif hm_item.material == hm_item.Materials.DIAMOND:
					AchievementsManager.complete_achievement_if_can(AchievementsManager.DIAMOND_AGE)
				elif hm_item.material == hm_item.Materials.RUBY:
					AchievementsManager.complete_achievement_if_can(AchievementsManager.RUBY_AGE)
			elif hm_item is Main.HMArmor:
				AchievementsManager.complete_achievement_if_can(AchievementsManager.IMPROVE_YOUR_OUTFIT)
					
	
func update():
	if hm_item:
		$Sprite.texture = load(hm_item.texture_path)
		
		if hm_item is Main.HMAttack:
			$Sprite.material.set_shader_param("r_1", Elements.get_color_element(hm_item.primary_element))
			$Sprite.material.set_shader_param("r_2", Elements.get_color_element(hm_item.secundary_element))
		
		HUD = get_tree().get_nodes_in_group("HUD")[0]
	
func _on_Area_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		can_take = true

func _on_Area_area_exited(area):
	if area.get_parent().is_in_group("Player"):
		can_take = false

func _on_Anim_animation_finished(anim_name):
	if anim_name == "take":
		queue_free()
