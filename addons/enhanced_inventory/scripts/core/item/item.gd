@tool
@icon("res://addons/enhanced_inventory/icons/icons8-item-24.png")
extends Resource
class_name Item

@export var name: String = ""
@export var icon: Texture2D
@export_multiline var description: String = ""
@export var is_collectable: bool = true

@export var is_stackable: bool = false
@export var max_stack_size: int = 1:
	get:
		return max_stack_size if is_stackable else 1
	set(size):
		max_stack_size = size if is_stackable else 1

###
# COMPONENTS
###
@export var components: Array[ItemComponent] = []

func has_component(component_class) -> bool:
	return components.any(func(component: ItemComponent): return is_instance_of(component, component_class))

func get_component(component_class) -> ItemComponent:
	for component in components:
		if is_instance_of(component, component_class):
			return component
	
	return null
