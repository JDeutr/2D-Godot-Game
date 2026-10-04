extends Area2D

@export var speed: float = 0.5
@export var lifetime: float = 1.0
@export var speedRamp: int = 100

const projectileDamage = 25
const speedCap = 1000

var direction: Vector2 = Vector2.RIGHT

func setup(spawn_position: Vector2, fire_direction: Vector2, _velocity: float) -> void:
	global_position = spawn_position
	direction = fire_direction
	rotation = fire_direction.angle()
	speed = 50

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	$Lifetime.wait_time = lifetime
	$Lifetime.one_shot = true
	$Lifetime.timeout.connect(queue_free)
	$Lifetime.start()

var time_passed = 0 
func _physics_process(delta: float) -> void:
	time_passed += delta
	var count = floor(time_passed / 0.2);
	if count >= 1:
		speed += (count * speedRamp)
		
		if speed >= speedCap:
			speed = speedCap
		
		time_passed -= (count * 0.1)
	position += direction * speed * delta

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("half_wall"):
		return
	
	if body.has_method("take_damage"):
		body.take_damage(projectileDamage)
	
	queue_free()
