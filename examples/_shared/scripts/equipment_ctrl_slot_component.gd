@tool
extends SlotControlComponent
class_name EquipmentSlotControlComponent

var texture_rect: TextureRect 

func _initialize() -> void:
	texture_rect = ctrl_slot.get_node("MarginContainer/EquipmentIcon")
	_on_slot_updated()


func _on_slot_updated() -> void:
	if slot == null:
		return

	var equipment_lock_slot_component: EquipmentLockSlotComponent = slot.get_component(EquipmentLockSlotComponent)

	if equipment_lock_slot_component == null:
		return push_warning("<Slot> %s has no <EquipmentLockSlotComponent>" % ctrl_slot.name)
	
	texture_rect.texture = EquipmentItemComponent.get_icon_type(equipment_lock_slot_component.equipment_type)
