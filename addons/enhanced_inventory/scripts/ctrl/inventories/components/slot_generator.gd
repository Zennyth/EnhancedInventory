extends InventoryControlComponent
class_name SlotGenerator

@export var packed_slot: PackedScene

func _initialize() -> void:
	inventory.bounded_slot.connect(_on_bounded_slot)

func _on_bounded_slot(slot: Slot) -> void:
	var ctrl_slot: Node = packed_slot.instantiate()

	if not ctrl_slot is SlotControl:
		return push_error("Couldn't instantiate 'packed_slot' as type <SlotControl>")

	ctrl_inventory.add_ctrl_slot(slot, ctrl_slot)
