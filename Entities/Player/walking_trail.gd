extends GPUParticles2D


func _on_move_state_machine_state_changed(new_state_name: String) -> void:
	emitting = (new_state_name != "Idle")
