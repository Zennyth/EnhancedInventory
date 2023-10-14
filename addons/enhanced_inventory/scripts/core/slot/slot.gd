@tool
@icon("res://addons/enhanced_inventory/icons/icons8-big-parcel-24.png")
extends Resource
class_name Slot

signal updated
signal stack_added(stack: Stack)
signal stack_removed(stack: Stack)

var index: int = -1
var inventory: Inventory

@export var stack: Stack:
	set(_stack):
		unbind_stack()
		stack = _stack
		bind_stack()
		
		update()


func bind_stack() -> void:
	if stack == null:
		return
	
	if not stack.is_empty():
		stack.get_item().bind_to_inventory(inventory)

	SignalUtils.connect_if_not_connected(stack.updated, update)
	stack_added.emit(stack)
	
func unbind_stack() -> void:
	if stack == null:
		return
	
	SignalUtils.disconnect_if_connected(stack.updated, update)
	stack_removed.emit(stack)

func update() -> void:
	updated.emit()


###
# INTERFACE
###
func accepts_item(item: Item) -> bool:
	return components.all(func(component: SlotComponent): return component.accepts_item(item))

func accepts_stack(stack: Stack) -> bool:
	return accepts_item(stack.item) and (is_empty() or (is_item_stackable() and get_item().equals_to(stack.get_item())))

func accepts_slot(slot: Slot) -> bool:
	return slot.is_empty() or accepts_stack(slot.stack)


###
# STACK OPERATORS
###
func pickup_stack(target: Stack) -> bool:
	if !is_empty() or target == null or target.is_empty() or !accepts_item(target.get_item()):
		return false
	
	stack = target
	return true

func unload_stack(target: Stack) -> int:
	if target == null or target.is_empty() or !accepts_item(target.get_item()):
		return -1
	
	if !is_empty():
		if !is_item_stackable() or !get_item().equals_to(target.get_item()):
			return -1
		
		return stack.fill_to(target.quantity)
	
	stack = target
	return 0

func swap_stack(target: Slot) -> bool:
	if not target.accepts_slot(self) or not accepts_slot(target):
		return false

	var temp: Stack = stack
	stack = target.stack
	target.stack = temp
	return true
	
func split_stack(target: Slot) -> bool:
	if target.is_empty() or !target.is_item_stackable() or target.stack.quantity <= 1:
		return false
	
	if not is_empty():
		if !get_item().equals_to(target.get_item()):
			return false
		
		var split_quantity := target.stack.split()
		var remaining_quantity := stack.fill_to(split_quantity)
		target.stack.fill_to(remaining_quantity)
		return true


	var split_quantity := target.stack.split()
	stack = Stack.new(target.get_item(), split_quantity)
	return true


###
# SLOT OPERATORS
###
func pickup_slot(target: Slot) -> bool:
	var res: bool = pickup_stack(target.stack)

	if res:
		target.stack = null

	return res

func unload_slot(target: Slot) -> int:
	var res: int = unload_stack(target.stack)

	if res == 0:
		target.stack = null
	
	return res

###
# COMPONENTS
###
@export var components: Array[SlotComponent] = []:
	set = set_components
var _components: Array[SlotComponent]

func set_components(value) -> void:
	components = value
	_components = []
	for component in components:
		if component == null:
			continue

		initialize_slot_component(component)

func initialize_slot_component(component: SlotComponent) -> void:
	var _component: SlotComponent = component.duplicate(true)
	_component.initialize_slot_component(self)
	_components.append(_component)

func has_component(component_class) -> bool:
	return _components.any(func(component: SlotComponent): return is_instance_of(component, component_class))

func get_component(component_class) -> SlotComponent:
	for component in _components:
		if is_instance_of(component, component_class):
			return component
	
	return null


###
# INVENTORY
###
func bind_to_inventory(_index: int, _inventory: Inventory) -> void:
	index = _index
	inventory = _inventory

	if stack != null and not stack.is_empty():
		stack.get_item().bind_to_inventory(inventory)


###
# DECORATOR
# Stack - Item
###
func is_empty() -> bool:
	return stack == null or stack.is_empty()

func get_item() -> Item:
	return stack.get_item() if stack != null else null

func get_item_name() -> String:
	return stack.get_item_name() if stack != null else ""

func is_item_stackable() -> bool:
	return stack != null and stack.is_item_stackable()

func is_item_collectable() -> bool:
	return stack != null and stack.is_item_collectable()

func get_item_max_stack_size() -> int:
	return stack.get_item_max_stack_size() if stack != null else 0


###
# EDITOR
###
@export_group("Resource")
@export var name: String = ""
@export var icon: Texture
