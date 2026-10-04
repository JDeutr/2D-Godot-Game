extends Node2D

var rng = RandomNumberGenerator.new()

@export var spawn_amount = 10
@export var training_dummy_prefab: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	for i in range(spawn_amount):
		spawn_dummy()


func spawn_dummy():
	var dummy = training_dummy_prefab.instantiate()

	var random_x = int(rng.randf_range(180, 600))
	var random_y = int(rng.randf_range(0, 300))

	var spawn_locaton = Vector2(random_x, random_y)

	dummy.position = spawn_locaton

	add_child(dummy)
