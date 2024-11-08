class_name Keys
extends InteractableItem

@export var key_type:Key
@export var animation_player:AnimationPlayer

func _use_item() -> void:
	GlobalScript.player_keys.append(key_type)
	GlobalScript.ui_text_picked_up.emit('picked up key')
	queue_free()
