extends Node3D

@export var resources:Array[PackedScene]
@export var craft_req:Dictionary
@onready var ammo_con: VBoxContainer = %AmmoCon
@onready var craft_button: Button = %CraftButton
@onready var resource_con: HBoxContainer = %ResourceCon
@onready var scrap_label: Label = %ScrapLabel
@onready var gunpowder_label: Label = %GunpowderLabel

var craft_item:String
var inv_data:InventoryData
var resource_array_name:Array[String] = ["Scrap", "Gunpowder"]
func _on_gui_interactor_item_is_being_used(inventory_data:InventoryData) -> void:
	inv_data = inventory_data
	scrap_label.text = str(inv_data.scrap) + " x Scrap"
	gunpowder_label.text = str(inv_data.scrap) + " x gunpowder"


func _on_ammo_button_pressed() -> void:
	resource_con.visible = !resource_con.visible
	ammo_con.visible = !ammo_con.visible
	craft_button.visible = false


func _craft_ammo(item_type:String) -> void:
	craft_button.visible = true
	craft_item = item_type


func _on_craft_button_pressed() -> void:
	if inv_data.scrap < craft_req[craft_item]["Scrap"]:
		print("not enough scrap")
		return
	if inv_data.gunpowder < craft_req[craft_item]["Gunpowder"]:
		print("not enough gunpowder")
		return
	instance_resource()
	inv_data.scrap -= craft_req[craft_item]["Scrap"]
	inv_data.gunpowder -= craft_req[craft_item]["Gunpowder"]
	_on_gui_interactor_item_is_being_used(inv_data)

func instance_resource() -> void:
	match craft_item:
		'PistolAmmo': 
			var instance:RigidBody3D = resources[0].instantiate()
			add_child(instance)
			instance.global_position = global_position
			instance.apply_impulse(Vector3.LEFT * 5)
		'ShotgunAmmo':
			pass
