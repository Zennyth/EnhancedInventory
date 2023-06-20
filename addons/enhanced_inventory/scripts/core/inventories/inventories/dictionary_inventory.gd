class_name DictionaryInventory
extends Inventory

@export var slots: Dictionary = {}


func get_slot(index) -> Slot:
	return slots[index] if index in slots else null

func set_slot(index, slot: Slot):
	slots[index] = slot
	super(index, slot)

func get_slots() -> Array[Slot]:
	var results: Array[Slot] = []

	for slot in slots.values():
		if !slot is Slot:
			continue
		
		results.append(slot)

	return results

func len() -> int:
	return len(slots)

func get_indexes() -> Array[int]:
	var keys: Array[int] = []

	for key in slots.keys():
		keys.append(key)

	return keys
