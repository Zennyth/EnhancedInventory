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
	item.quantity_changed.connect(_on_item_quantity_changed)
	item.bound_to_inventory.connect(_on_item_bound_to_inventory)
	_initialize_item_component()
	is_initialized = true

func _initialize_item_component() -> void:
	pass



func _on_item_quantity_changed() -> void:
	pass

func _on_item_bound_to_inventory() -> void:
	pass

func get_multilplayer_spawner_packed_scenes() -> Array[PackedScene]:
	return []
