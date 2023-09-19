@tool
@icon("res://addons/enhanced_inventory/icons/icons8-upload-to-cloud-24.png")
extends Node
class_name DatabaseInjectorMultiplayerSpawner

@onready var multiplayer_spawner: MultiplayerSpawner = get_parent()
@export var databases: Array[ItemDatabase] = []

func _ready() -> void:
	if Engine.is_editor_hint():
		return

	for database in databases:
		for item in database.get_items():
			for component in item.components:
				for packed_scene in component.get_multilplayer_spawner_packed_scenes():
					multiplayer_spawner.add_spawnable_scene(packed_scene.resource_path)


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []

	if not get_parent() is MultiplayerSpawner:
		warnings.append("Injectors must have a [MultiplayerSpawner] node as their parent.")

	return warnings