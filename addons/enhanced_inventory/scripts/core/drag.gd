extends Resource
class_name Drag

@export var drag_slot: Slot = Slot.new()

func interact_with_slot(slot: Slot) -> void:
	if drag_slot == null:
		return push_error("[DragSlot] must me configured !")

	if slot == null:
		return push_warning("<Slot> is null")
	

	if handle_pickup_stack(slot): 
		return
	
	if !slot_accept_item(slot):
		return
	
	if handle_drop_stack(slot):
		return
	
	# stack or swap
	if not slot.is_empty() and not drag_slot.is_empty():
		if handle_stack_items(slot):
			return
		
		handle_swap_stacks(slot)

func handle_split_stacks(target_slot: Slot) -> bool:
	if target_slot.is_empty() or !target_slot.is_item_stackable() or target_slot.stack.quantity <= 1:
		return false
	
	if not drag_slot.is_empty():
		if !drag_slot.get_item().equals_to(target_slot.get_item()):
			return false
		
		var split_quantity := target_slot.stack.split()
		var remaining_quantity := drag_slot.stack.fill_to(split_quantity)
		target_slot.stack.fill_to(remaining_quantity)
		return true


	var split_quantity := target_slot.stack.split()
	var new_stack := Stack.new()
	new_stack.quantity = split_quantity
	new_stack.item = target_slot.get_item()
	drag_slot.stack = new_stack
	return true


func handle_pickup_stack(target_slot: Slot) -> bool:
	if target_slot.is_empty() or !drag_slot.is_empty():
		return false
	
	drag_slot.stack = target_slot.stack
	target_slot.stack = null
	return true

func slot_accept_item(slot: Slot) -> bool:
	return !drag_slot.is_empty() and slot.accept_item(drag_slot.get_item()) 

func handle_drop_stack(target_slot: Slot) -> bool:
	if not target_slot.is_empty() or drag_slot.is_empty():
		return false
	
	target_slot.stack = drag_slot.stack
	drag_slot.stack = null
	return true

func handle_stack_items(target_slot: Slot) -> bool:
	if !target_slot.is_item_stackable() or !target_slot.get_item().equals_to(drag_slot.stack.get_item()):
		return false
	
	var remaining_quantity := target_slot.stack.fill_to(drag_slot.stack.quantity)
	if remaining_quantity == 0:
		drag_slot.stack = null
	else:
		drag_slot.stack.quantity = remaining_quantity
	return true

func handle_swap_stacks(target_slot: Slot) -> bool:
	var temp = drag_slot.stack
	drag_slot.stack = target_slot.stack
	target_slot.stack = temp
	return true