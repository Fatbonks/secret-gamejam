class_name InteractionSystem
extends Node

signal ui_text_picked_up(text:String)
signal found_key(key_type:String)
signal freeze_player(freeze:bool)

@export var pic_up_text:Label
@export var text_anim: AnimationPlayer

@onready var pistol_ammo: Label = %PistolAmmo
@onready var shotgun_ammo: Label = %ShotgunAmmo
@onready var amount_scrap: Label = %AmountScrap
@onready var amount_gunpowder: Label = %AmountGunpowder


var is_player_interacting:bool = false
var item:InteractableItem
var player_keys:Array[Key]

var inventory_data:InventoryData = InventoryData.new()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('interact') and is_player_interacting:
		item._use_item(self)

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is InteractableItem:
		item = area
		area.change_sprite_visibility()
		is_player_interacting = true


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area is InteractableItem:
		item = null
		area.change_sprite_visibility()
		is_player_interacting = false

func _set_text_pickup(text:String) -> void:
	pic_up_text.text = text
	text_anim.play('picked_up_anim')


func _on_arm_animation_update_ui() -> void:
	pistol_ammo.text = str(inventory_data.pistol_magazine) + " / " + str(inventory_data.max_pistol_magazine) + " pistol ammo"
	shotgun_ammo.text = str(inventory_data.shotgun_magazine) + " / " + str(inventory_data.max_shotgun_magazine) + " shotgun ammo"
	amount_scrap.text = str(inventory_data.scrap) + " scrap"
	amount_gunpowder.text = str(inventory_data.gunpowder) + " gunpowder"
