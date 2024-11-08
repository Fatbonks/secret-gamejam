class_name Player
extends CharacterBody3D

@export var mouse_sensitivity: float = 1.0
@export var speed: float = 5.0
@export var jump_height: float = 4.5

@export_category("camera settings")
@export_range(0, 20) var camera_tilt_amount: float
@export_range(0, 10) var camera_tilt_speed: float

@onready var camera_3d: Camera3D = %Camera3D



func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event:InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		camera_3d.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-89), deg_to_rad(89))
		#mouse_input = event.relative


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_height


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir:Vector2 = Input.get_vector("left", "right", "forward", "backward")
	var direction:Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	tilt_camera(roundi(input_dir.x), delta)
	move_and_slide()

func tilt_camera(input_direction: int, delta:float) -> void:
	print(input_direction)
	if input_direction == 0:
		camera_3d.rotation_degrees.z = lerpf(camera_3d.rotation_degrees.z, 0.0, camera_tilt_speed * delta)
	elif input_direction == 1:
		camera_3d.rotation_degrees.z = lerpf(camera_3d.rotation_degrees.z, -camera_tilt_amount, camera_tilt_speed * delta)
	elif input_direction == -1:
		camera_3d.rotation_degrees.z = lerpf(camera_3d.rotation_degrees.z, camera_tilt_amount, camera_tilt_speed * delta)
