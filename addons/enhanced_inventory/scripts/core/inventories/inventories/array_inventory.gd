class_name ArrayInventory
extends Inventory

@export var slots: Array[Slot] = []


func get_slot(index: int) -> Slot:
	if index >= length():
		return null

	return slots[index]

func append_slot(slot: Slot) -> void:
	var last_index := length()
	slots.append(slot)
	set_slot(last_index, slot)

func remove_slot(slot: Slot) -> void:
	var index: int = slots.find(slot)

	if index == -1:
		push_warning("%s doesn't belong to %s")
	
	slots.remove_at(index)

func set_slot(index: int, slot: Slot):
	slots[index] = slot
	super(index, slot)

func get_slots() -> Array:
	return slots

func length() -> int:
	return len(slots)

func get_indexes() -> Array:
	return range(length())
