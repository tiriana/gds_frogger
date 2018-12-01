extends Node2D
signal hit
signal drown

export (int) var speed  # How fast the player will move (pixels/sec).
var velocity = Vector2()

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

func _process(delta):
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

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_Frog_body_entered(body):
	hide() # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.disabled = true
