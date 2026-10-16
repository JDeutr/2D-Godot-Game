extends Node2D
var rng = RandomNumberGenerator.new()

@export var enemies: Dictionary[PackedScene,int]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for enemy in enemies:
		spawn(enemy)

func spawn(entity: PackedScene):
	for i in enemies[entity]:
		var dummy = entity.instantiate()

		var half_x = transform.x.x / 2
		var half_y = transform.y.y / 2
		
		var random_x = int(rng.randf_range(position.x - half_x, position.x + half_x))
		var random_y = int(rng.randf_range(position.y - half_y, position.y + half_y))

		var spawn_locaton = Vector2(random_x, random_y)

		dummy.position = spawn_locaton

		get_parent().add_child.call_deferred(dummy)
