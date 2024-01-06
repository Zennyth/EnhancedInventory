extends Resource
class_name Drag


@export var drag_slot: Slot = Slot.new():
	set = set_drag_slot


###
# INTERACTION
###
func interact_with_slot(slot: Slot) -> void:
	if drag_slot == null:
		return push_error("[DragSlot] must me configured !")

	if slot == null:
		return push_warning("<Slot> is null")
	

	if handle_pickup_slot(slot): 
		return
	
	if handle_unload_slot(slot):
		return
	
	if handle_swap_stack(slot):
		return
	
	# push_warning("[DragSlot] didn't find any interaction !")


func handle_split_stacks(target_slot: Slot) -> bool:
	return drag_slot.split_stack(target_slot)

func handle_pickup_slot(target_slot: Slot) -> bool:
	return drag_slot.pickup_slot(target_slot)

func handle_unload_slot(target_slot: Slot) -> bool:
	return target_slot.unload_slot(drag_slot) > -1

func handle_swap_stack(target_slot: Slot) -> bool:
	return drag_slot.swap_stack(target_slot)


###
# BEFORE INTERACTION
###
signal item_hold_changed(item: Item)

func set_drag_slot(value) -> void:
	if drag_slot != null:
		SignalUtils.disconnect_if_connected(drag_slot.updated, _on_drag_slot_updated)

	drag_slot = value

	if drag_slot != null:
		SignalUtils.connect_if_not_connected(drag_slot.updated, _on_drag_slot_updated)

func _on_drag_slot_updated() -> void:
	var item_hold: Item = drag_slot.get_item() if drag_slot != null else null
	item_hold_changed.emit(item_hold)
