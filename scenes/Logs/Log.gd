extends Node2D

export (int) var speed = 0

func _ready():
	$StaticBody2D.speedModifier = speed
	if speed < 0:
		scale.x = -1;
	pass
	
func move(delta):
	position += Vector2(1, 0) * speed * delta
	if position.x > 2000:
		position.x -= 4000
	if position.x < -2000:
		position.x += 4000

func _process(delta):
	move(delta)
	pass
