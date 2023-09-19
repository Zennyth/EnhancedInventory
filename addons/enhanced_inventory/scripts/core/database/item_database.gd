@tool
extends ResourceDatabase
class_name ItemDatabase

func is_valid(entry: Item) -> bool:
	return entry != null

func add_item(item: Item) -> void:
	if !is_valid(item):
		return

	_add_entry(item)

func remove_item(item: Item) -> void:
	_remove_entry(item)

func get_items() -> Array[Item]:
	var items: Array[Item] = []

	for resource in _get_resouces():
		if !is_valid(resource as Item):
			continue

		items.append(resource as Item)	
	
	return items

func get_by_id(id: String) -> Item:
	for resource in _get_resouces():
		if resource.id == id:
			return resource
	
	return null



func _get_property_list() -> Array:
	var result: Array = []

	result.append({ "name": "_resources", "class_name": &"", "type": 28, "hint": 23, "hint_string": "24/17:Item", "usage": 4102 })

	return result