extends Control
class_name DragControl

@onready var ctrl_slot: SlotControl = $SlotControl

func _process(_delta: float) -> void:
	set_position(get_global_mouse_position() + Vector2(10, 10))