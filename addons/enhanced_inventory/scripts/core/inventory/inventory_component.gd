@tool
@icon("res://addons/enhanced_inventory/icons/icons8-circuit-24.png")
extends Resource
class_name InventoryComponent


###
# CORE
###
var is_initialized: bool = false

var inventory: Inventory

func initialize_inventory_component(_inventory: Inventory) -> void:
	inventory = _inventory
	_initialize()
	is_initialized = true
	update_is_enabled()

@export var is_enabled: bool = true:
	set = set_is_enabled

func set_is_enabled(value) -> void:
	var was_enabled: bool = is_enabled
	is_enabled = value

	if is_enabled == was_enabled:
		return
	
	update_is_enabled()

func update_is_enabled() -> void:
	if !is_initialized:
		return

	if is_enabled:
		_enable()
	else:
		_disable()


###
# VIRTUALS
###
func _initialize() -> void:
	pass

func _enable() -> void:
	pass

func _disable() -> void:
	pass


###
# UTILS
###
func get_owner_component(class_to_find) -> Node:
	return NodeUtils.find_node(inventory.owner, class_to_find)