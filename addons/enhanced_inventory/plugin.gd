@tool
extends EditorPlugin

const InventoriesEventBus: String = "InventoriesEventBus"

const InventoryEditorInspector = preload("res://addons/enhanced_inventory/scripts/editor/inventory/inventory_editor_inspector.gd")
var inventory_editor_inspector: EditorInspectorPlugin

const ItemEditorInspector = preload("res://../../addons/enhanced_inventory/scripts/editor/item/item_editor_inspector.gd")
var item_editor_inspector: ItemEditorInspector


func _enter_tree():
	add_autoload_singleton(InventoriesEventBus, "res://addons/enhanced_inventory/scripts/autoloads/inventories_event_bus.gd")
	
	inventory_editor_inspector = InventoryEditorInspector.new()
	add_inspector_plugin(inventory_editor_inspector)

	item_editor_inspector = ItemEditorInspector.new()
	add_inspector_plugin(item_editor_inspector)


func _exit_tree():
	
	remove_autoload_singleton(InventoriesEventBus)
	remove_inspector_plugin(inventory_editor_inspector)
	remove_inspector_plugin(item_editor_inspector)