class_name GUIInteractor
extends InteractableItem
signal item_is_being_used
@export var snap_pos:Marker3D
@onready var camera_3d: Camera3D = %Camera3D
var in_menu:bool = false
var intract_sys: InteractionSystem
var player:Player

func _use_item(interact_sys:InteractionSystem) -> void:
	if in_menu:
		_leave_menu()
		return
	in_menu = true
	var tween:Tween = create_tween()
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	interact_sys.freeze_player.emit(true)
	intract_sys = interact_sys
	player = interact_sys.owner
	camera_3d.global_position = Vector3(player.global_position.x, player.global_position.y + 0.5, player.global_position.z)
	camera_3d.global_rotation_degrees = player.global_rotation_degrees
	camera_3d.global_rotation_degrees.x = camera_3d.global_rotation_degrees.x
	camera_3d.make_current()
	tween.set_parallel(true)
	tween.tween_property(camera_3d, "global_position", snap_pos.global_position, 0.2)
	tween.tween_property(camera_3d, "global_rotation_degrees", snap_pos.global_rotation_degrees, 0.2)
	item_is_being_used.emit()


func disable_cam() -> void:
	intract_sys.freeze_player.emit(false)
	camera_3d.current = false
	in_menu = false

func _leave_menu() -> void:
	var tween:Tween = create_tween()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	tween.set_parallel(true)
	tween.tween_property(camera_3d, "global_position", player.camera_3d.global_position, 0.2)
	tween.tween_property(camera_3d, "global_rotation_degrees", player.camera_3d.global_rotation_degrees, 0.2)
	tween.set_parallel(false)
	tween.tween_callback(disable_cam)
