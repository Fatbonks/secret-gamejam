extends Control
@onready var red_found: Label = %RedFound
@onready var white_found: Label = %WhiteFound
@onready var yellow_found: Label = %YellowFound

func _on_interact_system_found_key(key_type: String) -> void:
	if key_type == 'White key':
		white_found.text = 'Found'
	if key_type == 'Black key':
		yellow_found.text = 'Found'
	if key_type == 'Red key':
		red_found.text = 'Found'
