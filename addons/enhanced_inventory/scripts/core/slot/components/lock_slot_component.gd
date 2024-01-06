@tool
@icon("res://addons/enhanced_inventory/icons/icons8-lock-24.png")
extends SlotComponent
class_name LockSlotComponent

func accepts_item(item: Item) -> bool:
	return false