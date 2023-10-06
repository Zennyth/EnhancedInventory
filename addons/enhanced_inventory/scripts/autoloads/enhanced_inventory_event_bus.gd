@tool
extends Node
# EnhancedInventoryEventBus
var inventory_controls: Array[InventoryControl] = []

signal ctrl_inventory_initialized(ctrl_inventory: InventoryControl)

func initialize_inventory_control(inventory_control: InventoryControl) -> void:
	inventory_controls.append(inventory_control)
	ctrl_inventory_initialized.emit(inventory_control)


