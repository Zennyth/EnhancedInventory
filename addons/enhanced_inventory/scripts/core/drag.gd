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
	
	if handle_unload_stack(slot):
		return
	
	if handle_swap_stack(slot):
		return


func handle_split_stacks(target_slot: Slot) -> bool:
	return drag_slot.split_stack(target_slot)

func handle_pickup_stack(target_slot: Slot) -> bool:
	return drag_slot.pickup_stack(target_slot)

func handle_unload_stack(target_slot: Slot) -> bool:
	return drag_slot.unload_stack(target_slot)

func handle_swap_stack(target_slot: Slot) -> bool:
	return drag_slot.swap_stack(target_slot)