class_name Keys
extends InteractableItem

@export var key_type:Key

func _use_item(interact_sys:InteractionSystem) -> void:
	interact_sys.player_keys.append(key_type)
	interact_sys.ui_text_picked_up.emit('picked up key')
	interact_sys.found_key.emit(key_type.key_name)
	queue_free()
