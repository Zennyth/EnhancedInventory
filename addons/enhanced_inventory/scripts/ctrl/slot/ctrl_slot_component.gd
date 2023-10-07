@tool
@icon("res://addons/enhanced_inventory/icons/icons8-circuit-24-green.png")
extends Resource
class_name SlotControlComponent

var slot: Slot:
	get: return ctrl_slot.slot if ctrl_slot != null else null
var ctrl_slot: SlotControl

func initialize_slot_control_component(_ctrl_slot: SlotControl) -> void:
	ctrl_slot = _ctrl_slot
	SignalUtils.connect_if_not_connected(ctrl_slot.updated, _on_slot_updated)
	_initialize()

func _initialize() -> void:
	pass

func _on_slot_updated() -> void:
	pass