@tool
@icon("res://addons/enhanced_inventory/icons/icons8-sheets-24.png")
extends Resource
class_name Stack


signal updated
signal item_changed
signal quantity_changed

# @export
var item: Item:
	set = set_item

@export var quantity: int:
	set = set_quantity


func _init(_item: Item = null, _quantity: int = 0) -> void:
	item = _item
	quantity = _quantity


func set_item(_item: Item) -> void:
	item = _item
	item_changed.emit()
	update()

func set_quantity(_quantity: int):
	quantity = _quantity
	quantity_changed.emit()
	update()

func update() -> void:
	updated.emit()


###
# QUANTITY OPERATORS
###
func fill_to(add_quantity: int) -> int:
	var original_quantity := quantity
	var potential_quantity := original_quantity + add_quantity
	
	if potential_quantity > item.max_stack_size:
		quantity = item.max_stack_size
		return item.max_stack_size - potential_quantity
	
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



###
# MULTIPLAYER
###
func is_equal(stack: Stack) -> bool:
	if stack == null:
		return false
	
	return quantity == stack.quantity and item == stack.item

static func serialize(stack: Stack) -> Dictionary:
	if stack == null:
		return {}

	return {
		"item": stack.item.resource_path if not stack.is_empty() else null,
		"quantity": stack.quantity
	}

static func deserialize(dictionary: Dictionary) -> Stack:
	if dictionary.is_empty():
		return null

	var item: Item = load(dictionary.item) if dictionary.has("item") else null
	return Stack.new(item, dictionary.quantity)

func _get_property_list():
	var properties = []

	properties.append({ "name": "item", "class_name": &"Item", "type": 24, "hint": 17, "hint_string": "Item", "usage": 4102 | PROPERTY_USAGE_NEVER_DUPLICATE })

	return properties