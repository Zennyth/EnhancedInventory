extends Control
class_name InventoryControl


@export var inventory: Inventory:
	set = set_inventory

func set_inventory(value) -> void:
	inventory = value
	bind_slots()


@onready var ctrl_slots: Array[SlotControl] = NodeUtils.find_nodes(self, SlotControl) as Array[SlotControl]:
	set = set_ctrl_slots

func set_ctrl_slots(value) -> void:
	ctrl_slots = value
	bind_slots()


func bind_slots() -> void:
	if inventory == null or ctrl_slots == null:
		return
	
	for i in len(ctrl_slots):
		var ctrl_slot: SlotControl = ctrl_slots[i]
		var slot: Slot = inventory.get_slot(i)

		if slot == null or ctrl_slot == null:
			continue
		
		ctrl_slot.slot = slot