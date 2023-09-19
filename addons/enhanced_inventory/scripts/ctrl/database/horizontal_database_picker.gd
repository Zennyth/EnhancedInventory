extends HBoxContainer
class_name HorizontalDatabasePicker

signal item_selected(item: Item)

@export var packed_item: PackedScene
var database: ItemDatabase
var selected_item_control

func initialize(_database: ItemDatabase, default_item: Item = null) -> void:
	database = _database
	var items := database.get_items() 

	for item in database.get_items():
		var item_control: Control = packed_item.instantiate()
		item_control.item = item
		item_control.gui_input.connect(func(event: InputEvent): _on_item_control_selected(item_control, event))
		add_child(item_control)

		if default_item != null and item.id == default_item.id:
			_on_item_control_selected(item_control)

	if items.is_empty():
		return
	
	if default_item == null and selected_item_control == null:
		_on_item_control_selected(get_child(0))


func _on_item_control_selected(item_control, event: InputEvent = null) -> void:
	if event != null and (not event is InputEventMouseButton or not event.is_pressed()):
		return
	
	if selected_item_control != null:
		selected_item_control.is_selected = false
	
	selected_item_control = item_control
	item_control.is_selected = true
	item_selected.emit(item_control.item)
