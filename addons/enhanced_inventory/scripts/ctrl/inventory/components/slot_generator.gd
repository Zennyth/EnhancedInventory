@tool
extends InventoryControlComponent
class_name SlotInstantiator

@export var packed_slot: PackedScene

func _initialize() -> void:
	SignalUtils.connect_if_not_connected(inventory.bounded_slot, instantiate_slot)
	instantiate_on_initialize()

func instantiate_on_initialize() -> void:
	var ctrl_slots_len := len(ctrl_inventory.ctrl_slots)
	var slot_difference: int = inventory.length() - ctrl_slots_len

	if slot_difference < 0:
		return push_warning("%s has more <ControlSlot> than %s" % [ctrl_inventory, inventory])
	
	for i in range(slot_difference):
		instantiate_slot(inventory.get_slot(i + ctrl_slots_len))
	


func instantiate_slot(slot: Slot) -> void:
	var ctrl_slot: Node = packed_slot.instantiate()

	if not ctrl_slot is SlotControl:
		return push_error("Couldn't instantiate 'packed_slot' as type <SlotControl>")

	ctrl_inventory.add_ctrl_slot(slot, ctrl_slot)
