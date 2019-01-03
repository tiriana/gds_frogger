extends "res://scenes/MovingObject.gd"

export (float) var eatingProbability = 0

	
func swim():
	$AnimatedSprite.animation = "swim"
	get_node("KillingBody/CollisionShape2D").disabled = true
	pass

func eat():
	$AnimatedSprite.animation = "eating"
	get_node("KillingBody/CollisionShape2D").disabled = false
	pass

func _on_StatusChangeTimer_timeout():
	if randf() < eatingProbability:
		eat()
	else:
		swim()
	pass # replace with function body
