extends Node

signal update_ui()

@export var reset_position:Vector3
@export var reset_rotation:Quaternion

@onready var left_marker: Marker3D = %LeftMarker
@onready var right_marker: Marker3D = %RightMarker
@onready var arm_ui: Marker3D = %ArmHealthUI
@onready var arm_inventory_ui: Marker3D = %ArmInventoryUI
@onready var health_ui_sprite: Sprite3D = %HealthUISprite
@onready var inventory_ui_sprite: Sprite3D = %InventoryUISprite

var enable_health_ui:bool = false
var enable_inventory_ui:bool = false
var tween:Tween

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("show_health_ui") and !enable_health_ui:
		enable_health_ui = true
		tween_arm(arm_ui.position, arm_ui.quaternion)
		health_ui_sprite.visible = true
		inventory_ui_sprite.visible = false
		enable_inventory_ui = false
	elif event.is_action_pressed("show_health_ui") and enable_health_ui:
		enable_health_ui = false
		tween_arm(reset_position, reset_rotation)
		health_ui_sprite.visible = false
	
	if event.is_action_pressed("show_inventory_ui") and !enable_inventory_ui:
		enable_inventory_ui = true
		tween_arm(arm_inventory_ui.position, arm_inventory_ui.quaternion)
		inventory_ui_sprite.visible = true
		health_ui_sprite.visible = false
		enable_health_ui = false
		update_ui.emit()
	elif event.is_action_pressed("show_inventory_ui") and enable_inventory_ui:
		enable_inventory_ui = false
		tween_arm(reset_position, reset_rotation)
		inventory_ui_sprite.visible = false


func tween_arm(end_position:Vector3, end_rotation:Quaternion, time:float = 0.2):
	tween = create_tween()
	tween.parallel().tween_property(right_marker, 'position', end_position, time).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(right_marker, 'quaternion', end_rotation, time).set_ease(Tween.EASE_IN_OUT)
