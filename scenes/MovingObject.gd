extends Node2D

export (int) var speed = 0
export (int) var maxX = 1980;
export (int) var minX = -1980;

func clone():
	var copy = duplicate();
	copy.speed = speed
	copy._ready()
	return copy

func _ready():
	$StaticBody2D.speedModifier = speed
	if speed < 0:
		scale.x *= -1;
	pass
	
func getMaxX():
	return max(1728, maxX)
	
func getMinX():
	return min(-220, minX)
	
func move(delta):
	position += Vector2(1, 0) * speed * delta
	if position.x > getMaxX():
		position.x = getMinX()
	if position.x < getMinX():
		position.x = getMaxX()

func _process(delta):
	move(delta)
	pass
