@icon("res://addons/enhanced_inventory/icons/icons8-infinity-24.png")
extends InventoryComponent
class_name InfiniteCapacityInventoryComponent

@export var empty_slot_threshold: int = 5
@export var amount_to_add: int = 5

func get_number_of_empty_slots() -> int:
	return len(inventory.get_slots().filter(func(slot: Slot): return slot.is_empty()))


func _initialize() -> void:
	inventory.updated.connect(append_missing_slots)
	append_missing_slots()

func append_missing_slots() -> void:
	if get_number_of_empty_slots() > empty_slot_threshold:
		return
	
	for i in range(amount_to_add):
		inventory.append_slot(Slot.new())