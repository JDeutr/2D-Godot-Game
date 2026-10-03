extends Area2D

@export var speed: float = 4.0
@export var lifetime: float = 1.0
var direction: Vector2 = Vector2.RIGHT

func setup(spawn_position: Vector2, fire_direction: Vector2, velocity: float) -> void:
	global_position = spawn_position
	direction = fire_direction
	rotation = fire_direction.angle()
	speed = velocity

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	$Lifetime.wait_time = lifetime
	$Lifetime.one_shot = true
	$Lifetime.timeout.connect(queue_free)
	$Lifetime.start()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(10)
	queue_free()
