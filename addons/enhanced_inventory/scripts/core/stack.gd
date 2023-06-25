@tool
@icon("res://addons/enhanced_inventory/icons/icons8-sheets-24.png")
extends Resource
class_name Stack

signal updated
signal item_changed
signal quantity_changed


func _init(_item: Item = null, _quantity: int = -1) -> void:
	if _item != null:
		item = _item
	
	if _quantity != -1:
		quantity = _quantity


@export var item: Item:
	set(_item):
		item = _item
		item_changed.emit()
		update()

@export var quantity: int:
	set(_quantity):
		quantity = _quantity
		quantity_changed.emit()
		update()

func update() -> void:
	updated.emit()


###
# QUANTITY OPERATORS
###
func fill_to(add_quantity: int) -> int:
	if add_quantity <= 0:
		return 0

	var original_quantity := quantity
	var potential_quantity := original_quantity + add_quantity
	
	if potential_quantity > item.max_stack_size:
		quantity = item.max_stack_size
		return potential_quantity - item.max_stack_size
	
	quantity = potential_quantity
	return 0

func split() -> int:
	if quantity <= 1:
		return 0
	
	var remaining_odd: int = quantity % 2
	var split_quantity: int = floor(quantity / 2)
	
	quantity = split_quantity + remaining_odd

	return split_quantity


###
# DECORATOR
# Item
###
func is_empty() -> bool:
	return item == null or quantity == 0

func get_item() -> Item:
	return item

func get_item_name() -> String:
	return item.name if item != null else ""

func is_item_stackable() -> bool:
	return item != null and item.is_stackable

func is_item_collectable() -> bool:
	return item != null and item.is_collectable

func get_item_max_stack_size() -> int:
	return item.max_stack_size if item != null else 0
