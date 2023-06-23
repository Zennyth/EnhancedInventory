@tool
extends EditorInspectorPlugin

const InventoryComponentsPreviewPackedScene = preload("res://addons/enhanced_inventory/scenes/editor/inventory/inventory_components_preview/InventoryComponentsPreview.tscn")
const InventoryComponentsPreview = preload("res://addons/enhanced_inventory/scripts/editor/inventory/inventory_components_preview/inventory_components_preview.gd")

func _can_handle(object) -> bool:
    return object is Inventory


func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
    if name == "components":
        var preview: InventoryComponentsPreview = InventoryComponentsPreviewPackedScene.instantiate() as InventoryComponentsPreview
        preview.initialize(object as Inventory)
        add_custom_control(preview)
    
    return false