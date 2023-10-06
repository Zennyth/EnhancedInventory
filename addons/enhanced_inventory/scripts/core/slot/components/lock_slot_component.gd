@tool
@icon("res://addons/enhanced_inventory/icons/icons8-lock-24.png")
extends SlotComponent
class_name LockSlotComponent

func accepts_item(item: Item) -> bool:
	return item.id == "fbd67fe8-bf1e-404d-b93c-9a9447c3bd57"