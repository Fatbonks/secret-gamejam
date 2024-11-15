extends Door

@onready var doorele_1: MeshInstance3D = %Doorele1
@onready var doorele_2: MeshInstance3D = %Doorele2
@export var animation:AnimationPlayer

func _tween_door(value:float) -> void:
	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(doorele_1, 'position:x', value, 1)
	tween.tween_property(doorele_2, 'position:x', -value + -0.04, 1)

func _use_item(interact_sys:InteractionSystem) -> void:
	if is_locked:
		use_key(interact_sys.player_keys)
		return
	
	if !is_open:
		_tween_door(2)
	else:
		_tween_door(0.7)
	is_open = !is_open
