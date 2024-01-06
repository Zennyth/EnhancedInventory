# This component allows an inventory to be automatically saved upon any of its changes
@tool
@icon("res://addons/enhanced_inventory/icons/icons8-save-close-24.png")
extends InventoryComponent
class_name AutoSaverInventoryComponent


@export var path: String = ""

var computed_path: String:
	get: return path if path != "" else inventory.resource_path


func _enable() -> void:
	SignalUtils.connect_if_not_connected(inventory.updated, _on_inventory_updated)

func _disable() -> void:
	SignalUtils.disconnect_if_connected(inventory.updated, _on_inventory_updated)


func _on_inventory_updated() -> void:
	if computed_path == "" or computed_path == null:
		if inventory.is_template:
			return

		return push_warning("Could not find a path for the inventory to be saved !")
	
	if inventory.resource_path != "" or inventory.resource_path != null:
		# TODO: "emit_changed()" doesn't work
		ResourceSaver.save(inventory, inventory.resource_path)
		return emit_changed()
	
	ResourceSaver.save(inventory, path)
