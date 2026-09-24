extends Label




func _ready() -> void:
	pass


func _on_dodge_component_dodge_charges_changed(charges: Variant) -> void:
	text = str(charges)
