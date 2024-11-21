class_name InventoryData
extends Resource

var scrap:int = 5
var gunpowder:int = 5
var pistol_magazine:int:
	set(value):
		if value >= max_pistol_magazine:
			pistol_magazine = max_pistol_magazine
var shotgun_magazine:int:
	set(value):
		if value >= max_shotgun_magazine:
			shotgun_magazine = max_shotgun_magazine
var max_pistol_magazine = 5
var max_shotgun_magazine = 3
