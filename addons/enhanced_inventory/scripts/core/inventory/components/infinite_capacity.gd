# This component allows an inventory to automatically add slots when the number of empty slots reach the threshold
@tool
@icon("res://addons/enhanced_inventory/icons/icons8-infinity-24.png")
extends InventoryComponent
class_name InfiniteCapacityInventoryComponent


@export var empty_slot_threshold: int = 5
@export var amount_to_add: int = 5

func get_number_of_empty_slots() -> int:
	return len(inventory.get_slots().filter(func(slot: Slot): return slot == null or slot.is_empty()))


func _enable() -> void:
	append_missing_slots()
	SignalUtils.connect_if_not_connected(inventory.updated, append_missing_slots)

func _disable() -> void:
	inventory.updated.disconnect(append_missing_slots)


func append_missing_slots() -> void:
	if get_number_of_empty_slots() > empty_slot_threshold:
		return
	
	for i in range(amount_to_add):
		inventory.append_slot(Slot.new())
