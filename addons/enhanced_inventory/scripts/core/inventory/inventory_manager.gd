@icon("res://addons/enhanced_inventory/icons/icons8-backpack-24.png")
extends Node
class_name InventoryManager

@export var _inventory: Inventory:
	set(value):
		_inventory = value
		inventory = _inventory.get_instance() if _inventory != null else null

var inventory: Inventory

@export var auto_initialize: bool = true


## If [inventory_owner] is null, take the owner of the node
@export var inventory_owner: Node


func _ready() -> void:
	if not auto_initialize:
		return

	initialize()



###
# MULTIPLAYER and OWNER
###
@export_group("Multiplayer")
## Only allows the inventory_owner that is_multiplayer_authority to modify and replicate the inventory
@export var lock_to_autorithy: bool = false
var has_authority: bool = false
var has_multiplayer_authority: bool = false

func initialize() -> void:
	if inventory == null:
		return push_warning("Can't initialize <InventoryManager> without an inventory !")
	
	inventory_owner = inventory_owner if inventory_owner != null else owner
	
	has_multiplayer_authority = inventory_owner.is_multiplayer_authority()
	has_authority = !lock_to_autorithy or has_multiplayer_authority
	
	if has_authority:
		initialize_multiplayer_replication()
	
	inventory.initialize_manager(self)
	

	
	




func initialize_multiplayer_replication() -> void:
	for i in inventory.get_indexes():
		inventory.get_slot(i).updated.connect(_on_slot_updated.bind(i))

func _on_slot_updated(slot_index: int) -> void:
	var slot: Slot = inventory.get_slot(slot_index)
	update_inventory.rpc(slot_index, Stack.serialize(slot.stack))

@rpc("any_peer")
func update_inventory(slot_index: int, stack: Dictionary) -> void:
	var _stack: Stack = Stack.deserialize(stack)
	var slot: Slot = inventory.get_slot(slot_index)

	if _stack != null and _stack.is_equal(slot.stack):
		return
		
	if _stack == slot.stack:
		return
		
	slot.stack = _stack
