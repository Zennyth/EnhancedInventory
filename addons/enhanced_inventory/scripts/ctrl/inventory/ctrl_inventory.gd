@icon("res://addons/enhanced_inventory/icons/icons8-backpack-24-green.png")
extends Control
class_name InventoryControl


@export var inventory: Inventory:
	set = set_inventory

func set_inventory(value) -> void:
	inventory = value
	bind_slots_to_ctrl_slots()


@export var components: Array[InventoryControlComponent] = []

func initialize_inventory_control_components() -> void:
	for component in components:
		component.initialize_inventory_control_component(self)


@onready var ctrl_slots: Array[SlotControl] = fetch_ctrl_slots():
	set = set_ctrl_slots

func fetch_ctrl_slots() -> Array[SlotControl]:
	var slots: Array[SlotControl] = []

	for slot in NodeUtils.find_nodes(self, SlotControl):
		slots.append(slot as SlotControl)

	return slots

func set_ctrl_slots(value) -> void:
	ctrl_slots = value
	bind_slots_to_ctrl_slots()

func add_ctrl_slot(slot: Slot, ctrl_slot: SlotControl) -> void:
	add_child(ctrl_slot)
	ctrl_slots.append(ctrl_slot)
	bind_slot_to_ctrl_slot(slot, ctrl_slot)

func _ready() -> void:
	bind_slots_to_ctrl_slots()
	InventoriesEventBus.ctrl_inventory_initialized.emit(self)



func bind_slots_to_ctrl_slots() -> void:
	if inventory == null or ctrl_slots == null or ctrl_slots.is_empty():
		return
	
	initialize_inventory_control_components()
	
	for i in inventory.get_indexes():
		var slot: Slot = inventory.get_slot(i)
		
		if len(ctrl_slots) <= i:
			continue

		var ctrl_slot: SlotControl = ctrl_slots[i]
		bind_slot_to_ctrl_slot(slot, ctrl_slot)

func bind_slot_to_ctrl_slot(slot: Slot, ctrl_slot: SlotControl) -> void:
	if slot == null or ctrl_slot == null or ctrl_slot.slot == slot:
		return
	
	ctrl_slot.slot = slot
