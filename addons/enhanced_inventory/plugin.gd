@tool
extends EditorPlugin

const EnhancedInventoryEventBus: String = "EnhancedInventoryEventBus"

const InventoryEditorInspector = preload("res://addons/enhanced_inventory/scripts/editor/inventory/inventory_editor_inspector.gd")
var inventory_editor_inspector: EditorInspectorPlugin

const ItemEditorInspector = preload("res://addons/enhanced_inventory/scripts/editor/item/item_editor_inspector.gd")
var item_editor_inspector: ItemEditorInspector

const SlotControlEditorInspector = preload("res://addons/enhanced_inventory/scripts/editor/slot/ctrl_slot_editor_inspector.gd")
var slot_control_editor_inspector: SlotControlEditorInspector


func _enter_tree():
	add_autoload_singleton(EnhancedInventoryEventBus, "res://addons/enhanced_inventory/scripts/autoloads/enhanced_inventory_event_bus.gd")
	
	inventory_editor_inspector = InventoryEditorInspector.new()
	add_inspector_plugin(inventory_editor_inspector)

	item_editor_inspector = ItemEditorInspector.new()
	add_inspector_plugin(item_editor_inspector)

	slot_control_editor_inspector = SlotControlEditorInspector.new()
	add_inspector_plugin(slot_control_editor_inspector)


func _exit_tree():
	
	remove_autoload_singleton(EnhancedInventoryEventBus)
	remove_inspector_plugin(inventory_editor_inspector)
	remove_inspector_plugin(item_editor_inspector)
	remove_inspector_plugin(slot_control_editor_inspector)