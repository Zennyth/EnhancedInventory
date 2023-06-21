@icon("res://addons/enhanced_inventory/icons/icons8-save-close-24.png")
extends InventoryComponent
class_name InfiniteCapacityInventoryComponent

@export var empty_slot_threshold: int = 5

func get_number_of_empty_slots() -> int:
	return len(inventory.get_slots().filter(func(slot: Slot): return slot.is_empty))


func _initialize() -> void:
	inventory.updated.connect(_on_inventory_updated)

func _on_inventory_updated() -> void:
	if get_number_of_empty_slots() > empty_slot_threshold:
		pass