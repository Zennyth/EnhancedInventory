@tool
extends Control

@onready var texture_rect: TextureRect = $TextureRect 

var inventory_component: InventoryComponent

func initialize(_inventory_component: InventoryComponent) -> void:
	inventory_component = _inventory_component

func _ready() -> void:
	var filepath: String = (inventory_component.get_script() as Script).resource_path
	var script_classes := ProjectSettings.get_global_class_list()
	var custom_class: Dictionary
	
	for a_class in script_classes:
		if a_class.path == filepath:
			custom_class = a_class
			break
	
	if custom_class == null:
		return
	
	texture_rect.texture = load(custom_class.icon) as Texture2D
	
	var source_code: String = (inventory_component.get_script() as Script).source_code 
	var before_class_name: String = source_code.left(source_code.find("extends "))
	var comment_index = before_class_name.find("#")

	if comment_index != -1:
		var comment = before_class_name.right(-comment_index - 1)
		comment = comment.left(comment.find("\n")).strip_edges()
		tooltip_text = "[%s] \n%s" %[custom_class.class, comment]