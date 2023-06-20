@tool
extends EditorPlugin


const InventoryEditorInspector = preload("res://addons/enhanced_inventory/scripts/editor/inventories/inventory_editor_inspector.gd")
var inventory_editor_inspector: EditorInspectorPlugin

func _enter_tree():
	inventory_editor_inspector = InventoryEditorInspector.new()
	add_inspector_plugin(inventory_editor_inspector)

func _exit_tree():
	remove_inspector_plugin(inventory_editor_inspector)