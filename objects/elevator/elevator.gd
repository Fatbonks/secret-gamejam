class_name ElevatorLevelLoader
extends Node3D

signal load_level(value:int)

@onready var elevator_door: Door = %ElevatorDoor


func _on_level_1_pressed() -> void:
	load_level.emit(0)
	elevator_door.is_locked = true


func _on_level_2_pressed() -> void:
	load_level.emit(1)


func _on_elevator_level_selector_close_elevator() -> void:
	elevator_door._tween_door(0.6, 1)
	elevator_door.is_open = false
