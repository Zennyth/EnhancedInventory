@icon("res://addons/enhanced_inventory/icons/icons8-drag-and-drop-24-green.png")
extends Control
class_name DragControl

@export var drag: Drag
@export var mouse_offset: Vector2 = Vector2(10, 10)

@onready var ctrl_slot: SlotControl = $SlotControl

func _init() -> void:
	EnhancedInventoryEventBus.ctrl_inventory_initialized.connect(_on_ctrl_inventory_initialized)

func _ready() -> void:
	if drag == null:
		return push_error("%s drag property cannot be null !" % name)

	ctrl_slot.slot = drag.drag_slot

func _process(_delta: float) -> void:
	set_position(get_global_mouse_position() + mouse_offset)


func _on_ctrl_inventory_initialized(ctrl_inventory: InventoryControl) -> void:
	for initialized_ctrl_slot in ctrl_inventory.ctrl_slots:
		bind_initialized_ctrl_slot(initialized_ctrl_slot)

func bind_initialized_ctrl_slot(initialized_ctrl_slot: SlotControl) -> void:
	initialized_ctrl_slot.gui_input.connect(func(event: InputEvent): _on_ctrl_slot_gui_input(event, initialized_ctrl_slot))

func _on_ctrl_slot_gui_input(event: InputEvent, interactible_ctrl_slot: SlotControl) -> void:
	if not event is InputEventMouseButton or not event.is_pressed():
		return
	
	var target_slot := interactible_ctrl_slot.slot as Slot
	
	if event.button_index == MOUSE_BUTTON_LEFT:
		drag.interact_with_slot(target_slot)
	elif event.button_index == MOUSE_BUTTON_RIGHT:
		drag.handle_split_stacks(target_slot)

