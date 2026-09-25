extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	self.rotation = (mouse_pos - global_position).angle() + PI
	
	if mouse_pos.x > global_position.x:
		flip_v = true
	else:
		flip_v = false
		
	if mouse_pos.y > global_position.y:
		z_index = 1
	else:
		z_index = -1
