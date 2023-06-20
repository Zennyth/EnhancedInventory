extends Control
class_name StackControl

@onready var ctrl_item: ItemControl 	= $ItemControl
@onready var ctrl_text: Label 			= $Label


var stack: Stack:
	set = set_stack

func set_stack(value) -> void:
	unbind_stack()
	stack = value
	bind_stack()
	update_ctrl_item()

func bind_stack() -> void:
	if stack == null:
		return

	stack.updated.connect(_on_stack_updated)

func unbind_stack() -> void:
	if stack == null:
		return

	stack.updated.disconnect(_on_stack_updated)


func _on_stack_updated() -> void:
	update_ctrl_item()
	ctrl_text.text = str(stack.quantity) if stack != null else ""

func update_ctrl_item() -> void:
	ctrl_item.item = stack.item if !stack.is_empty() else null
