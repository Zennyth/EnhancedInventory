@tool
@icon("res://addons/enhanced_inventory/icons/icons8-backpack-24-green.png")
extends Control
class_name InventoryControl

signal bounded_ctrl_slot(ctrl_slot: SlotControl)


@export var container: Control


###
# INVENTORY_MANAGER
###
var inventory_manager: InventoryManager

###
# INVENTORY_RESOURCE
###
var inventory: Inventory:
	set = set_inventory

func set_inventory(value) -> void:
	inventory = value




## Still an experimental feature, use it at your own risks
@export var sync_in_editor: bool = false:
	set = set_sync_in_editor

func set_sync_in_editor(value: bool) -> void:
	sync_in_editor = value

	if is_node_ready():
		initialize()

var is_initializable: bool:
	get: return (!Engine.is_editor_hint() or sync_in_editor) and !is_initialized
var is_initialized: bool = false


@onready var ctrl_slots: Array[SlotControl] = fetch_ctrl_slots():
	set = set_ctrl_slots

func fetch_ctrl_slots() -> Array[SlotControl]:
	var slots: Array[SlotControl] = []

	for slot in NodeUtils.find_nodes(container, SlotControl):
		slots.append(slot as SlotControl)

	return slots

func set_ctrl_slots(value) -> void:
	ctrl_slots = value

func add_ctrl_slot(slot: Slot, ctrl_slot: SlotControl) -> void:
	if container == null:
		return
	
	if !container.is_node_ready():
		await container.ready
	
	container.add_child(ctrl_slot)

	if Engine.is_editor_hint():
		container.owner = get_tree().edited_scene_root
	
	ctrl_slots.append(ctrl_slot)
	bind_slot_to_ctrl_slot(slot, ctrl_slot)

	for ctrl_slot_component in ctrl_slot_components:
		ctrl_slot.initialize_slot_control_component(ctrl_slot_component)
	
	bounded_ctrl_slot.emit(ctrl_slot)


func _ready() -> void:
	initialize()	

func initialize() -> void:
	if !is_initializable:
		return

	if container == null:
		container = self
	
	if mode == Mode.INVENTORY_MANAGER:
		if inventory_manager == null:
			return push_error("<InventoryControl>.inventory_manager has not been configured properly !")
	
		inventory = inventory_manager.inventory
	
	if mode == Mode.INVENTORY_RESOURCE:
		if inventory == null:
			return push_error("<InventoryControl>.inventory has not been configured properly !")

		inventory.initialize()
	

	bind_slots_to_ctrl_slots()
	EnhancedInventoryEventBus.initialize_inventory_control(self)

func bind_slots_to_ctrl_slots() -> void:
	if inventory == null:
		return
		
	if !is_initializable:
		return

	for ctrl_slot in ctrl_slots:
		if ctrl_slot.slot_index == -1:
			push_warning("<Slot> %s has no slot index set, and therefore cannot be bound" % ctrl_slot.name)
			continue
		
		if inventory.get_slot(ctrl_slot.slot_index) == null:
			push_warning("<Slot> %s has an index that doesn't exist in the inventory, and therefore cannot be bound" % ctrl_slot.name)
			continue
		
		bind_slot_to_ctrl_slot(inventory.get_slot(ctrl_slot.slot_index), ctrl_slot)
	
	initialize_inventory_control_components()

	
	for i in inventory.get_indexes():
		var slot: Slot = inventory.get_slot(i)
		
		if len(ctrl_slots) <= i:
			continue

		var ctrl_slot: SlotControl = ctrl_slots[i]
		bind_slot_to_ctrl_slot(slot, ctrl_slot)
	
	initialize_ctrl_slot_components()

	is_initialized = true

func bind_slot_to_ctrl_slot(slot: Slot, ctrl_slot: SlotControl) -> void:
	if slot == null or ctrl_slot == null or ctrl_slot.slot == slot:
		return
	
	ctrl_slot.slot = slot



###
# COMPONENTS
###
@export var components: Array[InventoryControlComponent] = []

func initialize_inventory_control_components() -> void:
	if !is_initializable:
		return

	for component in components:
		component.initialize_inventory_control_component(self)



###
# SLOT COMPONENTS
###
@export var ctrl_slot_components: Array[SlotControlComponent] = []

func initialize_ctrl_slot_components() -> void:
	for ctrl_slot in ctrl_slots:
		for ctrl_slot_component in ctrl_slot_components:
			ctrl_slot.initialize_slot_control_component(ctrl_slot_component)


###
# EDITOR
###
enum Mode {
	INVENTORY_RESOURCE,
	INVENTORY_MANAGER
}

@export var mode: Mode = Mode.INVENTORY_RESOURCE:
	set = set_mode

func set_mode(value) -> void:
	mode = value
	notify_property_list_changed()

func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []

	match mode:
		Mode.INVENTORY_RESOURCE:
			properties.append({
				"name": "inventory",
				"usage": PROPERTY_USAGE_DEFAULT,
				"type": TYPE_OBJECT,
				"hint": PROPERTY_HINT_RESOURCE_TYPE,
				"hint_string": "Inventory",
				"class_name": &"Inventory",
			})
		Mode.INVENTORY_MANAGER:
			properties.append({
				"name": "inventory_manager",
				"usage": PROPERTY_USAGE_DEFAULT,
				"type": TYPE_OBJECT,
				"hint": PROPERTY_HINT_NODE_TYPE,
				"hint_string": "InventoryManager",
				"class_name": &"InventoryManager",
			})

	return properties
