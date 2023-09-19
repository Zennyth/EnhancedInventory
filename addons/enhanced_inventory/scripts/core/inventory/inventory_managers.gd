@icon("res://addons/enhanced_inventory/icons/icons8-warehouse-24.png")
extends Node
class_name InventoryManagers

var inventory_managers: Array[InventoryManager]:
	get = get_inventory_managers

func get_inventory_managers() -> Array[InventoryManager]:
	var results: Array[InventoryManager] = []

	for inventory_manager in NodeUtils.find_nodes(self, InventoryManager):
		results.append(inventory_manager as InventoryManager)
	
	return results