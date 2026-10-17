extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.

@warning_ignore("unused_parameter", "shadowed_variable_base_class")
func _on_health_component_health_changed(current: int, max_value: int) -> void:
	value = current;

func setup(o_max_health: int):
	value = o_max_health
	max_value = o_max_health
