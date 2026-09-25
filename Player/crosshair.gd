extends Marker2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var crosshair = preload("res://Art/crosshair.svg")
	Input.set_custom_mouse_cursor(crosshair)
	pass
