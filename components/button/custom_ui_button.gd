class_name CustomUIButton
extends Button
signal resource(resource_name:String)

@export_enum("PistolAmmo", "ShotgunAmmo") var resource_name: String = "PistolAmmo"

func _ready() -> void:
	pass

func show_resource() -> void:
	resource.emit(resource_name)
