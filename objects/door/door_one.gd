extends Door

@onready var pivot: Node3D = %Pivot

func _tween_door(value:float) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(pivot, 'rotation_degrees:y', value, 0.2)


func use_key(keys:Array[Key]) -> void:
	for key in keys:
		if key.key_name == door_key.key_name:
			is_locked = false
			label.text = text[1]
