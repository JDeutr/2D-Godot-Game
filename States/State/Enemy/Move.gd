extends State

var speed: float = 50;

func physics_update(_delta: float) -> void:
	var enemy = owner as Enemy
	var direction = (enemy.target.position - enemy.position).normalized()
	enemy.velocity = lerp(enemy.velocity, direction * enemy.speed, 8.5 * _delta)
	enemy.move_and_slide()
	
	if direction.x > 0:
		enemy.sprite.flip_h = false
	elif direction.x > 0:
		enemy.sprite.flip_h = true
