@icon("res://addons/enhanced_inventory/icons/icons8-backpack-24.png")
extends Node
class_name InventoryManager

@export var _inventory: Inventory:
	set(value):
		_inventory = value
		inventory = _inventory.duplicate(true) if _inventory != null else null

var inventory: Inventory

@export_group("Inventory Owner")
@export var initialize_owner: bool = true
# If [inventory_owner] is null, take the owner of the node
@export var inventory_owner: Node

func _ready() -> void:
	if inventory == null or !initialize_owner:
		return

	if not is_multiplayer_authority():
		return
	
	inventory.initialize_inventory_components()
	inventory.initialize_owner(inventory_owner if inventory_owner != null else owner)