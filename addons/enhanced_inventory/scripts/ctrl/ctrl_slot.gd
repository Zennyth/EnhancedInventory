@icon("res://addons/enhanced_inventory/icons/icons8-big-parcel-24-green.png")
extends Control
class_name SlotControl

signal selected
signal unselected
signal clicked

@onready var ctrl_stack: StackControl = NodeUtils.find_node(self, StackControl) as StackControl

var slot: Slot:
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


