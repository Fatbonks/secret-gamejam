class_name Door
extends InteractableItem

@export var is_locked:bool 
@export_multiline var text:Array[String]
@export var door_key:Key

@onready var label: Label = %Label

var is_open:bool = false

func _ready() -> void:
	if is_locked:
		label.text = text[0]
	else:
		label.text = text[1]


func _use_item(interact_sys:InteractionSystem) -> void:
	if is_locked:
		use_key(interact_sys.player_keys)
		return
	
	if !is_open:
		_tween_door(90)
	else:
		_tween_door(0)
	is_open = !is_open


func _tween_door(value:float) -> void:
	pass

func use_key(keys:Array[Key]) -> void:
	pass
