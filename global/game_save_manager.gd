class_name GameSaveManager
extends Node

var json:JSON = JSON.new()


func _save_data() -> void:
	var save_nodes:Array = get_tree().get_nodes_in_group('save_info')
	for node in save_nodes:
		if node.send_data != null:
			node.send_data.emit()


func _ready() -> void:
	_save_data()
