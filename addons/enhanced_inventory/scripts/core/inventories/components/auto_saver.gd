@icon("res://addons/enhanced_inventory/icons/icons8-save-close-24.png")
extends InventoryComponent
class_name AutoSaverInventoryComponent


@export var path: String = ""

var computed_path: String:
    get: return path if path != "" else inventory.resource_path

func _initialize() -> void:
	inventory.updated.connect(_on_inventory_updated)

func _on_inventory_updated() -> void:
    if computed_path == "" or computed_path == null:
        return push_warning("Could not find a path for the inventory to be saved !")

    ResourceSaver.save(inventory, computed_path)