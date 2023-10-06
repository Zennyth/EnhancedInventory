@tool
@icon("res://addons/enhanced_inventory/icons/icons8-big-parcel-24-green.png")
extends Control
class_name SlotControl

signal selected
signal unselected
signal clicked

@onready var ctrl_stack: StackControl = NodeUtils.find_node(self, StackControl) as StackControl

@export var slot: Slot:
	set = set_slot

func set_slot(value) -> void:
	unbind_slot()
	slot = value
	bind_slot()
	_on_slot_updated()

func bind_slot() -> void:
	if slot == null:
		return

	slot.updated.connect(_on_slot_updated)

func unbind_slot() -> void:
	if slot == null:
		return

	slot.updated.disconnect(_on_slot_updated)

func _on_slot_updated() -> void:
	ctrl_stack.stack = slot.stack if slot != null else null


func _ready() -> void:
	initialize_slot_control_components()


###
# INTERACTIONS
###
signal interaction_updated()

var is_interactable: bool = true

func update_interaction(item: Item) -> void:
	is_interactable = get_is_interactable(item)
	interaction_updated.emit()
	modulate = Color(1, 1, 1) if is_interactable else Color(0.404, 0.404, 0.404)

func get_is_interactable(item: Item) -> bool:
	if slot == null:
		return false
	
	if item == null:
		return true
	
	return slot.accepts_item(item)


###
# COMPONENTS
###
@export var components: Array[SlotControlComponent] = []

func initialize_slot_control_components() -> void:
	for component in components:
		component.initialize_slot_control_component(self)