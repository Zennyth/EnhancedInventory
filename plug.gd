extends "res://addons/gd-plug/plug.gd"

func _plugging():
	plug("Zennyth/EnhancedCommon", {"include": ["addons/enhanced_common/"], "branch": "develop"})
	plug("MikeSchulze/gdUnit4", {"include": ["addons/gdUnit4/"], "branch": "master"})