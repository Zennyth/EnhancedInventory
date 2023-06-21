@icon("res://addons/enhanced_inventory/icons/icons8-circuit-24.png")
extends Resource
class_name InventoryControlComponent

var inventory: Inventory:
	get: return ctrl_inventory.inventory if ctrl_inventory != null else null
var ctrl_inventory: InventoryControl

func initialize_inventory_control_component(_ctrl_inventory: InventoryControl) -> void:
    ctrl_inventory = _ctrl_inventory
	_initialize()

func _initialize() -> void:
	pass