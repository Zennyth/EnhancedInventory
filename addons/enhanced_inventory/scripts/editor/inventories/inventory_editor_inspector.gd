extends EditorInspectorPlugin

# const SlotGeneratorButton = preload("res://addons/enhanced_state_chart/scenes/editor/SignalPickerButton.tscn")

func _can_handle(object) -> bool:
    return object is Inventory


func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
    # if name == "source_path":
    #     var button = SlotGeneratorButton.instantiate()
    #     button.initialize(object as Inventory)
    #     add_custom_control(button)
    
    return false