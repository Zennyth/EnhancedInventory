extends EnhancedEditorInspectorPlugin


func _can_handle(object) -> bool:
	return object is SlotControl


func _parse_begin(object: Object) -> void:
	if object.slot == null:
		return
	
	var inventory_control: InventoryControl = NodeUtils.find_parent_node(object, InventoryControl)

	if inventory_control == null:
		return
	


