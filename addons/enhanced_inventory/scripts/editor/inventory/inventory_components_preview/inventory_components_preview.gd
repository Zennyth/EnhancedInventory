@tool
extends HBoxContainer

const InventoryComponentIconPackedScene = preload("res://addons/enhanced_inventory/scenes/editor/inventory/inventory_components_preview/InventoryComponentIcon.tscn")
const InventoryComponentIcon = preload("res://addons/enhanced_inventory/scripts/editor/inventory/inventory_components_preview/inventory_component_icon.gd")

@onready var hbox_container: HBoxContainer = $HBoxContainer

var inventory: Inventory

func initialize(_inventory: Inventory) -> void:
	inventory = _inventory

func _ready() -> void:
	for component in inventory.components:
		var icon: InventoryComponentIcon = InventoryComponentIconPackedScene.instantiate() as InventoryComponentIcon
		icon.initialize(component)
		hbox_container.add_child(icon)
