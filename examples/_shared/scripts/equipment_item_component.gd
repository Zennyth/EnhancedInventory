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

const TYPE_ICON_MAP = {
	Type.HEAD: preload("res://examples/_shared/assets/Krise Icon pack/helmet_02a.png"),
	Type.BODY: preload("res://examples/_shared/assets/Krise Icon pack/armor_01a.png"),
	Type.HANDS: preload("res://examples/_shared/assets/Krise Icon pack/gloves_01a.png"),
	Type.FEET: preload("res://examples/_shared/assets/Krise Icon pack/boots_01a.png"),

	Type.WEAPON: preload("res://examples/_shared/assets/Krise Icon pack/sword_01a.png"),
	Type.SHIELD: preload("res://examples/_shared/assets/Krise Icon pack/shield_02a.png"),
}

static func get_icon_type(type: Type) -> Texture2D:
	return TYPE_ICON_MAP[type]