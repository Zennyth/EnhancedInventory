@tool
extends Button

var inventory: Inventory
var signal_picker

func initialize(_inventory: Inventory) -> void:
    inventory = _inventory
    pressed.connect(_on_pressed)


func _on_pressed() -> void:    
    pass    
