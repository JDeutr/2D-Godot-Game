extends Marker2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var crosshair = preload("res://Art/UI/crosshair.svg")
	var hotspot = crosshair.get_size() / 2
	Input.set_custom_mouse_cursor(crosshair, Input.CURSOR_ARROW, hotspot)
