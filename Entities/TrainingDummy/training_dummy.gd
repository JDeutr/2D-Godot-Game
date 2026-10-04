extends CharacterBody2D

var health = 100

func take_damage(damage:int):
	health -= damage
	$Label.text = str(health)
	$Timer.start(1.0)
	
	if health <= 0:
		queue_free()

func _on_timer_timeout() -> void:
	$Label.text = ""
