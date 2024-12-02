class_name World
extends Node3D
## level script for all levels for my game
@export_category('Player')
@export var player:Player


@export_category('Levels')
@export var levels:Dictionary
@export var starter_level:LevelScene

@onready var timer: Timer = %Timer
@onready var audio_stream_player_3d: AudioStreamPlayer3D = %AudioStreamPlayer3D
@onready var elevator: ElevatorLevelLoader = %Elevator

var is_loading_level:bool = false
var current_level_string:String
var loaded_scene:PackedScene
var current_level_scene:LevelScene

func _ready() -> void:
	current_level_scene = starter_level

func _on_elevator_load_level(value: int) -> void:
	current_level_scene.queue_free()
	randomize()
	var rand = randi_range(0, levels[value].size() - 1)
	current_level_string = levels[value][rand]
	ResourceLoader.load_threaded_request(current_level_string)
	is_loading_level = true



func _process(_delta:float) -> void:
	if is_loading_level:
		audio_stream_player_3d.play()
		var level_array:Array
		ResourceLoader.load_threaded_get_status(current_level_string, level_array)
		if level_array[0] == 1:
			timer.start(2)
			is_loading_level = false


func _on_timer_timeout() -> void:
	var tween:Tween = create_tween()
	var scene:PackedScene = ResourceLoader.load_threaded_get(current_level_string)
	current_level_scene = scene.instantiate()
	add_child(current_level_scene)
	current_level_scene.global_position = current_level_scene.level_position
	tween.tween_property(audio_stream_player_3d, 'volume_db', -80, 5)
	await tween.finished
	audio_stream_player_3d.stop()
	audio_stream_player_3d.volume_db = -28
	elevator.elevator_door.is_locked = false
	elevator.elevator_door._update_text()
	
