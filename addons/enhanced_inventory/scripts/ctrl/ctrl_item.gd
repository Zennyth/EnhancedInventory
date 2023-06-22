@icon("res://addons/enhanced_inventory/icons/icons8-item-24-green.png")
extends Control
class_name ItemControl

@onready var texture_rect: TextureRect = $TextureRect


var item: Item:
	set = set_item

func set_item(value) -> void:
	item = value
	texture_rect.texture = item.icon if item != null else null
