@tool
extends LockSlotComponent
class_name EquipmentLockSlotComponent

@export var equipment_type: EquipmentItemComponent.Type = EquipmentItemComponent.Type.HEAD

func accepts_item(item: Item) -> bool:
	if not item.has_component(EquipmentItemComponent):
		return false
	
	return item.get_component(EquipmentItemComponent).equipment_type == equipment_type