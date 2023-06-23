@tool
@icon("res://addons/enhanced_item/icons/icons8-circuit-24.png")
extends Resource
class_name ItemComponent

var item: Item

func initialize_item_component(_item: Item) -> void:
	item = _item
	_initialize()

func _initialize() -> void:
	pass