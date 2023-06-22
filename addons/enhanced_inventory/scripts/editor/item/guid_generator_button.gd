@tool
extends Button

var item: Item

func initialize(_item: Item) -> void:
	item = _item
	pressed.connect(_on_pressed)


func _on_pressed() -> void:    
	if item == null:
		return push_error("<Item> cannot be null")
	
	item.id = Guid.v4()
