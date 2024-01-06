@tool
@icon("res://addons/enhanced_item/icons/icons8-circuit-24.png")
extends Resource
class_name ItemComponent

var is_initialized: bool = false
var item: Item

func initialize_item_component(_item: Item) -> void:
	if is_initialized:
		return

	item = _item
	_initialize_item_component()
	is_initialized = true

func _initialize_item_component() -> void:
	pass

func get_multilplayer_spawner_packed_scenes() -> Array[PackedScene]:
	return []
