extends Control
class_name InventoryControl


@export var inventory: Inventory:
	set = set_inventory

func set_inventory(value) -> void:
	inventory = value
	bind_slots()


@export var components: Array[InventoryControlComponent] = []

func initialize_inventory_control_components() -> void:
	components = value
	
	for component in components:
		component.initialize_inventory_control_component(self)


@onready var ctrl_slots: Array[SlotControl] = get_ctrl_slots():
	set = set_ctrl_slots

func get_ctrl_slots() -> Array[SlotControl]:
	return NodeUtils.find_nodes(self, SlotControl) as Array[SlotControl]

func set_ctrl_slots(value) -> void:
	ctrl_slots = value
	bind_slots_to_ctrl_slots()

func add_ctrl_slot(slot: Slot, ctrl_slot: SlotControl) -> void:
	bind_slot_to_ctrl_slot(slot, ctrl_slot)
	ctrl_slots.append(ctrl_slot)
	add_child(ctrl_slot)



func bind_slots_to_ctrl_slots() -> void:
	if inventory == null or ctrl_slots == null:
		return
	
	initialize_inventory_control_components()
	
	for i in inventory.get_indexes():
		var slot: Slot = inventory.get_slot(i)
		var ctrl_slot: SlotControl = ctrl_slots[i]
		bind_slot_to_ctrl_slot(slot, ctrl_slot)

func bind_slot_to_ctrl_slot(slot: Slot, ctrl_slot: SlotControl) -> void:
	if slot == null or ctrl_slot == null:
		return
	
	ctrl_slot.slot = slot