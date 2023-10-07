extends EnhancedEditorInspectorPlugin


func _can_handle(object) -> bool:
	return object is SlotControl


func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
	if name == "slot_index":	
		var inventory_control: InventoryControl = NodeUtils.find_parent_node(object, InventoryControl)

		if inventory_control == null:
			return false
		
		
		var slots: Array[Slot] = inventory_control.inventory.get_slots()
		var options: Array = slots.map(get_object_from_slot.bind(slots))
		
		var option_properties: OptionProperties = OptionProperties.new()
		# option_properties.property_set.connect(_on_slot_option_set.bind(slots, object))
		option_properties.initialize(object, name, options, false)

		add_custom_editor_inspector_container("Bind Slot", option_properties)

		return true

	return false


func get_object_from_slot(slot: Slot, slots: Array[Slot]) -> Dictionary:
	return {
		"name": slot.name if slot.name != "" and slot.name != null else "Slot",
		"value": slots.find(slot),
		"icon": slot.icon.resource_path if slot.icon != null else ClassUtils.get_custom_class(slot).icon
	}

# func _on_slot_option_set(option, slots: Array[Slot], slot_control: SlotControl) -> void:
# 	slot_control.slot = slots[option.value]

