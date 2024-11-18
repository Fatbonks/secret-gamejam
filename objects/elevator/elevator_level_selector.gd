extends InteractableItem
signal close_elevator
@onready var camera_3d: Camera3D = %Camera3D
@export var snap_pos:Marker3D

var in_menu:bool = false
var intract_sys: InteractionSystem
func _use_item(interact_sys:InteractionSystem) -> void:
	in_menu = true
	var tween:Tween = create_tween()
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	interact_sys.freeze_player.emit()
	intract_sys = interact_sys
	var player:Player = interact_sys.owner
	camera_3d.global_position = Vector3(player.global_position.x, player.global_position.y + 0.5, player.global_position.z)
	camera_3d.global_rotation_degrees = player.global_rotation_degrees
	camera_3d.global_rotation_degrees.x = camera_3d.global_rotation_degrees.x
	camera_3d.make_current()
	tween.set_parallel(true)
	tween.tween_property(camera_3d, "global_position", snap_pos.global_position, 1)
	tween.tween_property(camera_3d, "global_rotation_degrees", snap_pos.global_rotation_degrees, 1)
	monitorable = false
	close_elevator.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and in_menu:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		intract_sys.freeze_player.emit()
		camera_3d.current = false
		in_menu = false
		monitorable = true
