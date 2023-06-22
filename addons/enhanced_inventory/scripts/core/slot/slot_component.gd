@icon("res://addons/enhanced_inventory/icons/icons8-memory-slot-24.png")
extends Resource
class_name SlotComponent

var slot: Slot

func initialize_slot_component(_slot: Slot) -> void:
	slot = _slot
	_initialize()

func _initialize() -> void:
	pass

###
# VIRTUALS
###
func accept_item(item: Item) -> bool:
	return true