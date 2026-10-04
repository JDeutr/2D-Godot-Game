extends Area2D

const projectileDamage = 80

@export var speed: float = 300.0
@export var lifetime: float = 0.3
var direction: Vector2 = Vector2.RIGHT

func setup(spawn_position: Vector2, fire_direction: Vector2, _velocity: float) -> void:
	global_position = spawn_position
	direction = fire_direction
	rotation = fire_direction.angle()

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	$Lifetime.wait_time = lifetime
	$Lifetime.one_shot = true
	$Lifetime.timeout.connect(queue_free)
	$Lifetime.start()

func _physics_process(delta: float) -> void:
	position += direction * (speed * delta * 3)
	scale.x += speed * delta

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("half_wall"):
		return
		
	if body.has_method("take_damage"):
		body.take_damage(projectileDamage)

	queue_free()
