extends CharacterBody2D

var maxHealth: float = 100
var currentHealth: float = maxHealth

func _ready() -> void:
	$HP.max_value = maxHealth
	$HP.value = currentHealth
	
func take_damage(damage: int):
	currentHealth -= damage
	$HP.visible = true
	$HP.value = currentHealth
	$Timer.start(1.0)
	
	if currentHealth <= 0:
		queue_free()


func _on_timer_timeout() -> void:
	$HP.visible = false
