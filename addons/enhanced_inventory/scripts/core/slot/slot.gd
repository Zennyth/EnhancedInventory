@icon("res://addons/enhanced_inventory/icons/icons8-big-parcel-24.png")
extends Resource
class_name Slot

signal updated
signal stack_added(stack: Stack)
signal stack_removed(stack: Stack)

@export var stack: Stack:
	set(_stack):
		unbind_stack()
		stack = _stack
		bind_stack()
		
		_on_updated()


func bind_stack() -> void:
	if stack == null:
		return
	
	stack.updated.connect(_on_updated)
	stack_added.emit(stack)
	
func unbind_stack() -> void:
	if stack == null:
		return
	
	SignalUtils.disconnect_if_connected(stack.updated, _on_updated)
	stack_removed.emit(stack)

func _on_updated() -> void:
	updated.emit()


###
# INTERFACE
###
func accept_item(item: Item) -> bool:
	return components.all(func(component: SlotComponent): return component.accept_item(item))



###
# COMPONENTS
###
@export var components: Array[SlotComponent] = []:
	set = set_components

func set_components(value) -> void:
	components = value
	for component in components:
		component.initialize_slot_component(self)



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
