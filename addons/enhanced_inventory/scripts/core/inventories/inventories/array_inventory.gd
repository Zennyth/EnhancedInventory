class_name ArrayInventory
extends Inventory

@export var slots: Array[Slot] = []


func get_slot(index: int) -> Slot:
	if index < super.len():
		return null

	return slots[index]

func set_slot(index: int, slot: Slot):
	slots[index] = slot
	super(index, slot)

func get_slots() -> Array:
	return slots

func len() -> int:
	return len(slots)

func get_indexes() -> Array:
	return range(super.len())