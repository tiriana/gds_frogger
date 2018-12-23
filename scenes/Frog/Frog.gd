extends Node2D
signal died
signal won

export (int) var speed  # How fast the player will move (pixels/sec).
var velocity = Vector2()

var timeInDanger
var timeAtHome

var collidesWithDanger
var isCarried
var isAtHome

var carrier

var directions = {
	"up": {
		"velocity": Vector2(0, -1),
		"rotation": 0,
		"ui": "ui_up",
		"priority": 0
	},
	"down": {
		"velocity": Vector2(0, 1),
		"rotation": PI,
		"ui": "ui_down",
		"priority": 0
	},
	"left": {
		"velocity": Vector2(-1, 0),
		"rotation": -PI / 2,
		"ui": "ui_left",
		"priority": 0
	},
	"right": {
		"velocity": Vector2(1, 0),
		"rotation": PI / 2,
		"ui": "ui_right",
		"priority": 0
	}
}

var highest_priority = 0
var current_direction = {
		"velocity": Vector2(0, 0),
		"rotation": 0
	}
	
func _ready():
	pass
	
func _find_highest_direction():
	var highest = {
		"velocity": Vector2(0, 0),
		"priority": 0,
		"rotation": rotation
	}
	for direction in directions.values():
		if direction["priority"] > highest["priority"]:
			highest = direction
	return highest
	
func move(delta):
	for direction in directions.values():
		if Input.is_action_just_released(direction["ui"]):
			direction["priority"] = 0;
			current_direction = _find_highest_direction()
			highest_priority = current_direction["priority"]
		if Input.is_action_just_pressed(direction["ui"]):
			highest_priority += 1
			direction["priority"] = highest_priority
			current_direction = direction
			
	velocity = current_direction["velocity"]
	rotation = current_direction["rotation"]

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
        $AnimatedSprite.stop()
	position += velocity * delta
	
	if carrier:
		position += Vector2(1, 0) * carrier.speedModifier * delta

func printState():
	print("timeInDanger ", timeInDanger, "timeAtHome ", timeAtHome, "collidesWithDanger ", collidesWithDanger)
	print(" ")

func updateState(delta):
	if collidesWithDanger:
		timeInDanger += delta
	else:
		timeInDanger = 0
	
	if isCarried:
		timeInDanger = 0
	
	if isAtHome:
		timeAtHome += delta
	else:
		timeAtHome = 0

func emit_signals_if_needed():
	if timeInDanger > 0.1:
		return die()
	
	if timeAtHome > 0.1:
		return win()

func die():
	hide()
	emit_signal("died")

func win():
	hide() 
	emit_signal("won")



func _process(delta):
	move(delta)
	updateState(delta)
	emit_signals_if_needed()

func start(pos):
	position = pos
	timeInDanger = 0
	timeAtHome = 0
	collidesWithDanger = false
	isAtHome = false
	isCarried = false
	show()

func _on_Frog_body_entered(body):
	print("entered body ", body.isSafe, body.isDanger, body.isHome, body.speedModifier)
	
	if body.isSafe:
		carrier = body;
	collidesWithDanger = body.isDanger
	isCarried = body.isSafe
	isAtHome = body.isHome

func _on_Frog_body_exited(body):
	print("exited body ", body.isSafe, body.isDanger, body.isHome, body.speedModifier)
	if body.isDanger:
		collidesWithDanger = false
#
	if body.isSafe:
		isCarried = false
		if carrier == body:
			carrier = $_NULL
#
	if body.isHome:
		isAtHome = false

func _on_DebugTimer_timeout():
#	printState()
	pass
