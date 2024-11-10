class_name Door
extends InteractableItem

@export var is_locked:bool 
@export_multiline var text:Array[String]
@export var door_key:Key
@onready var pivot: Node3D = %Pivot
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
		tween_door(90)
	else:
		tween_door(0)
	is_open = !is_open


func tween_door(rot_value:int) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(pivot, 'rotation_degrees:y', rot_value, 0.2)

func use_key(keys:Array[Key]) -> void:
	for key in keys:
		if key.key_name == door_key.key_name:
			is_locked = false
			label.text = text[1]
