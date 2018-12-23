extends Node2D

export (int) var speed = 0
var maxLength = 1980;

func _ready():
	$StaticBody2D.speedModifier = speed
	if speed < 0:
		scale.x = -1;
	pass
	
func move(delta):
	position += Vector2(1, 0) * speed * delta
	if position.x > maxLength:
		position.x -= maxLength * 2
	if position.x < -maxLength:
		position.x += maxLength * 2

func _process(delta):
	move(delta)
	pass
