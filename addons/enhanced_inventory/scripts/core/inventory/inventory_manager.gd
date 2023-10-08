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
	
	inventory.initialize_manager(self)
	
	if has_authority:
		initialize_multiplayer_replication()

	
	




func initialize_multiplayer_replication() -> void:
	for slot in inventory.get_slots():
		slot.updated.connect(_on_slot_updated.bind(slot))
	
	inventory.bounded_slot.connect(_on_bounded_slot)
	inventory.unbounded_slot.connect(_on_unbounded_slot)



###
# BIND SLOT
###
func _on_bounded_slot(slot: Slot) -> void:
	slot.updated.connect(_on_slot_updated.bind(slot))
	bind_slot.rpc(slot.index)

@rpc("any_peer")
func bind_slot(slot_index: int) -> void:
	if inventory.get_slot(slot_index):
		return

	var slot: Slot = Slot.new()
	inventory.slots.insert(slot_index, slot)
	inventory.set_slot(slot_index, slot)


###
# UNBIND SLOT
###
func _on_unbounded_slot(slot: Slot) -> void:
	slot.updated.disconnect(_on_slot_updated)
	unbind_slot.rpc(slot.index)

@rpc("any_peer")
func unbind_slot(slot_index: int) -> void:
	inventory.slots.remove_at(slot_index)

###
# UPDATE SLOT
###
func _on_slot_updated(slot: Slot) -> void:
	update_slot.rpc(slot.index, Stack.serialize(slot.stack))

@rpc("any_peer")
func update_slot(slot_index: int, stack: Dictionary) -> void:
	var _stack: Stack = Stack.deserialize(stack)
	var slot: Slot = inventory.get_slot(slot_index)

	if _stack != null and _stack.is_equal(slot.stack):
		return
		
	if _stack == slot.stack:
		return
		
	slot.stack = _stack
