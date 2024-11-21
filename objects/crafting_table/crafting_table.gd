extends Node3D

@export var resources:Array[PackedScene]
@export var Gui:GUIInteractor
@export var craft_req:Dictionary
@onready var ammo_con: VBoxContainer = %AmmoCon
@onready var craft_button: Button = %CraftButton
@onready var resource_con: HBoxContainer = %ResourceCon
@onready var scrap_label: Label = %ScrapLabel
@onready var gunpowder_label: Label = %GunpowderLabel

var craft_ammo_type:String
func _ready() -> void:
	for button:Button in ammo_con.get_children():
		button.pressed.connect(_craft_ammo.bind(button))

func _on_gui_interactor_item_is_being_used() -> void:
	scrap_label.text = str(Gui.intract_sys.inventory_data.scrap) + " x Scrap"
	gunpowder_label.text = str(Gui.intract_sys.inventory_data.gunpowder) + " x gunpowder"


func _on_ammo_button_pressed() -> void:
	resource_con.visible = !resource_con.visible
	ammo_con.visible = !ammo_con.visible
	craft_button.visible = false


func _craft_ammo(button_type:Button) -> void:
	craft_button.visible = true
	if button_type.name == "PistolButton":
		craft_ammo_type = "PistolAmmo"
	elif button_type.name == "ShotgunButton":
		craft_ammo_type = "ShotgunAmmo"


func _on_craft_button_pressed() -> void:
	if Gui.intract_sys.inventory_data.scrap < craft_req[craft_ammo_type]["Scrap"]:
		print("not enough scrap")
		return
	if Gui.intract_sys.inventory_data.gunpowder < craft_req[craft_ammo_type]["Gunpowder"]:
		print("not enough gunpowder")
		return
	instance_resource()
	Gui.intract_sys.inventory_data.scrap -= craft_req[craft_ammo_type]["Scrap"]
	Gui.intract_sys.inventory_data.gunpowder -= craft_req[craft_ammo_type]["Gunpowder"]
	_on_gui_interactor_item_is_being_used()

func instance_resource() -> void:
	print(craft_ammo_type)
	match craft_ammo_type:
		'PistolAmmo': 
			print("a")
			var instance:RigidBody3D = resources[0].instantiate()
			add_child(instance)
			instance.global_position = global_position
			instance.apply_impulse(Vector3.LEFT * 5)
