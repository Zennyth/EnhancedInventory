extends EditorInspectorPlugin

const GuidGeneratorButton = preload("res://addons/enhanced_inventory/scenes/editor/item/GuidGeneratorButton.tscn")

func _can_handle(object) -> bool:
	return object is Item


func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
	if name == "id":
		var button = GuidGeneratorButton.instantiate()
		button.initialize(object as Item)
		add_custom_control(button)
	
	return false