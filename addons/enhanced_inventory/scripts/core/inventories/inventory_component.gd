@icon("res://addons/enhanced_inventory/icons/icons8-circuit-24.png")
extends Resource
class_name InventoryComponent

var inventory: Inventory

func initialize_inventory_component(_inventory: Inventory) -> void:
    inventory = _inventory
	_initialize()

func _initialize() -> void:
	pass