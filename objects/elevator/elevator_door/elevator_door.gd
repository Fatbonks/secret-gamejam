extends Door

@onready var doorele_1: MeshInstance3D = %Doorele1
@onready var doorele_2: MeshInstance3D = %Doorele2
@onready var open_door: AudioStreamPlayer3D = %OpenDoor
@onready var close_door: AudioStreamPlayer3D = %CloseDoor

var is_running:bool
var tween:Tween
func _tween_door(value:float, time:float = 3.5) -> void:
	if tween != null:
		tween.kill()
	tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(doorele_1, 'position:x', value, time)
	tween.tween_property(doorele_2, 'position:x', -value, time)


func _use_item(interact_sys:InteractionSystem) -> void:
	if is_locked:
		use_key(interact_sys.player_keys)
		return
	
	if !is_open:
		_tween_door(2)
		close_door.play()
	else:
		_tween_door(0.6)
		close_door.play()
	is_open = !is_open
