@icon("res://addons/enhanced_inventory/icons/icons8-backpack-24.png")
extends Resource
class_name Inventory

signal updated
signal bounded_slot(slot: Slot)
signal unbounded_slot(slot: Slot)


###
# INITIALIZATION
###
func _init() -> void:
	initialize_inventory()

func initialize_inventory() -> void:
	initialize_slots()


###
# CORE
###
func initialize_slots() -> void:
	for slot in get_slots():
		bind_slot(slot)


func get_slot(_index: int) -> Slot:
	return null

func append_slot(_slot: Slot) -> void:
	push_error("This type of inventory isn't expendable.")

func remove_slot(_slot: Slot) -> void:
	push_error("This type of inventory isn't expendable.")

func set_slot(index: int, slot: Slot) -> void:
	if slot == null:
		return push_warning("Can't set null slot at index: ", index)
	
	bind_slot(slot)

func bind_slot(slot: Slot) -> void:
	SignalUtils.connect_if_not_connected(slot.updated, _on_updated)
	bounded_slot.emit(slot)

func unbind_slot(slot: Slot) -> void:
	SignalUtils.disconnect_if_not_connected(slot.updated, _on_updated)
	unbounded_slot.emit(slot)

func _on_updated() -> void:
	updated.emit()

func get_slots() -> Array[Slot]:
	return []

func length() -> int:
	return -1

func get_indexes() -> Array[int]:
	return []




###
# PUBLIC
###
func get_items() -> Array[Item]:
	var items: Array[Item] = []

	for slot in get_slots():
		if slot and not slot.is_empty():
			items.append(slot.get_item())
	
	return items

func set_stack(index: int, new_stack: Stack) -> Stack:
	var slot: Slot = get_slot(index)

	var previous_stack: Stack = slot.stack
	slot.stack = new_stack
	return previous_stack

func remove_stack(index: int) -> Stack:
	var slot: Slot = get_slot(index)

	var previous_stack: Stack = slot.stack
	slot.stack = null
	return previous_stack

func set_stack_quantity(index, amount: int) -> int:
	var slot: Slot = get_slot(index)
	return slot.stack.fill_to(amount)

func pick_up_stack(stack: Stack) -> bool:
	for slot in get_slots():
		if not slot.is_empty():
			continue
		
		slot.stack = stack
		return true

	return false


###
# COMPONENTS
###
@export var components: Array[InventoryComponent] = []:
	set = set_components

func set_components(value) -> void:
	components = value
	initialize_inventory_components()

func initialize_inventory_components() -> void:
	for component in components:
		component.initialize_inventory_component(self)