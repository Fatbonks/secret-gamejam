class_name ResourceInteracter
extends InteractableItem

@export_enum("scrap", "gunpowder", "pistol_magazine", "shotgun_magazine") var resource_type: String
@export var amount:int = 1
@onready var outline_mesh: MeshInstance3D = %OutlineMesh
@onready var collision_shape_3d: CollisionShape3D = %CollisionShape3D


func _use_item(_interact_sys:InteractionSystem) -> void:
	var tween:Tween = create_tween()
	var current_val:int = _interact_sys.inventory_data.get(resource_type)
	_interact_sys.inventory_data.set(resource_type, (current_val + amount))
	_interact_sys._on_arm_animation_update_ui()
	collision_shape_3d.disabled = true
	tween.tween_property(owner as RigidBody3D, 'global_position', _interact_sys.owner.global_position, 0.1)
	await tween.finished
	owner.queue_free()

func change_sprite_visibility() -> void:
	outline_mesh.visible = !outline_mesh.visible
