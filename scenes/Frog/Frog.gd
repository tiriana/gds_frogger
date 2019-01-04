extends Node2D
signal died
signal won

export (int) var speed  # How fast the player will move (pixels/sec).
var velocity = Vector2()
var isInteractive = false

var leftTop
var bottomRight
var timeInDanger
var timeAtHome

var isAtHome

var carriers = []
var danger = []
var lethalDanger = []
var lastHome;

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
	if isInteractive:
		
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
	
	if carriers.size() > 0:
		position += Vector2(1, 0) * carriers[0].speedModifier * delta

func setBoundries(_leftTop, _bottomRight):
	leftTop = _leftTop
	bottomRight = _bottomRight
	
func clampFrog():
	position.x = clamp(position.x, leftTop.position.x + 36, bottomRight.position.x - 36)
	position.y = clamp(position.y, leftTop.position.y + 36, bottomRight.position.y - 36)

func printState():
	print("carriers ", carriers.size(), " danger ", danger.size())
	print(" ")

func updateState(delta):
	if danger.size() > 0:
		timeInDanger += delta
	else:
		timeInDanger = 0
	
	if carriers.size() > 0 and lethalDanger.size() == 0:
		timeInDanger = 0
	
	if isAtHome:
		timeAtHome += delta
	else:
		timeAtHome = 0

func emit_signals_if_needed():
	if timeInDanger > 0.05:
		return die()
	
	if timeAtHome > 0.05:
		return win()

func die():
	hide()
	emit_signal("died")

func win():
	hide() 
	lastHome.markAsFull()
	emit_signal("won")

func _process(delta):
	move(delta)
	updateState(delta)
	emit_signals_if_needed()
	clampFrog()
	
func reset():
	highest_priority = 0
	current_direction = {
		"velocity": Vector2(0, 0),
		"rotation": 0
	}
	velocity = Vector2()

func start(pos):
	position = pos
	timeInDanger = 0
	timeAtHome = 0
	danger = []
	carriers = []
	isAtHome = false
	rotation = 0
	show()
	$CollisionShape2D.disabled = false

func _on_Frog_body_entered(body):
	if body.isCarrying and !carriers.has(body):
		if velocity.length() > 0:
			carriers.push_front(body)
		else:
			carriers.push_back(body)
	
	if body.isDanger:
		danger.push_back(body)
	
	if body.isLethal:
		lethalDanger.push_back(body)
	
	if body.isHome:
		isAtHome = true
		lastHome = body.get_node("../");

func _on_Frog_body_exited(body):
	if body.isDanger:
		while(danger.has(body)):
			danger.remove(danger.find(body));
			
	if body.isLethal:
		while(lethalDanger.has(body)):
			lethalDanger.remove(lethalDanger.find(body));
		
	if body.isCarrying:
		while(carriers.has(body)):
			carriers.remove(carriers.find(body));
#
	if body.isHome:
		isAtHome = false

