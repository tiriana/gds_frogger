extends Node2D

export (int) var speed = 0
var isLog = true


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$StaticBody2D.speed = speed
	pass
	
func move(delta):
	position += Vector2(1, 0) * speed * delta
	if position.x > 3000:
		position.x -= 6000
	if position.x < -3000:
		position.x += 6000

func _process(delta):
	move(delta)
	pass
