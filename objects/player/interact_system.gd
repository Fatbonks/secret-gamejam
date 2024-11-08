extends Node

var is_player_interacting:bool = false
var item:InteractableItem

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('interact') and is_player_interacting:
		item._use_item()
		

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is InteractableItem:
		item = area
		area.change_sprite_visibility()
		is_player_interacting = true


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area is InteractableItem:
		item = null
		area.change_sprite_visibility()
		is_player_interacting = false
