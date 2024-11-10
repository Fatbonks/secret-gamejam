class_name Keys
extends InteractableItem

@export var key_type:Key

func _use_item(interact_sys:InteractionSystem) -> void:
	interact_sys.player_keys.append(key_type)
	interact_sys.ui_text_picked_up.emit('picked up key')
	queue_free()
