class_name InteractableItem
extends Area3D

@export var _3d_text_sprite: Sprite3D

func _use_item() -> void:
	pass

func change_sprite_visibility() -> void:
	if _3d_text_sprite == null:
		printerr(owner.name + " does not have a sprite to change")
		return
	_3d_text_sprite.visible = !_3d_text_sprite.visible
