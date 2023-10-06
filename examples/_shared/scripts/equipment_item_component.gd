@icon("res://examples/_shared/assets/Krise Icon pack/helmet_02b.png")
extends ItemComponent
class_name EquipmentItemComponent

enum Type {
	HEAD,
	BODY,
	HANDS,
	FEET,

	WEAPON,
	SHIELD
}

@export var equipment_type: Type = Type.HEAD