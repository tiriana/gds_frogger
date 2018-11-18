extends Node2D

export (int) var speed  # How fast the player will move (pixels/sec).
var screensize  # Size of the game window.
var velocity = Vector2()

var input_to_v_and_r = {
	"ui_right": {
		velocity: Vector2(1, 0),
		rotation: PI / 2
	},
	"ui_left": {
		velocity: Vector2(-1, 0),
		rotation: -PI / 2
	},
	"ui_down": {
		velocity: Vector2(0, 1),
		rotation: PI
	},
	"ui_up": {
		velocity: Vector2(0, -1),
		rotation: 0
	}
}

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		rotation = PI / 2
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		rotation = -PI / 2
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		rotation = PI
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		rotation = 0
		
	if Input.is_action_just_released("ui_right"):
		velocity.x = 0
	if Input.is_action_just_released("ui_left"):
		velocity.x = 0
	if Input.is_action_just_released("ui_down"):
		velocity.y = 0
	if Input.is_action_just_released("ui_up"):
		velocity.y = 0
		
	if Input.is_action_just_pressed("ui_right"):
		velocity.y = 0
	if Input.is_action_just_pressed("ui_left"):
		velocity.y = 0
	if Input.is_action_just_pressed("ui_down"):
		velocity.x = 0
	if Input.is_action_just_pressed("ui_up"):
		velocity.x = 0
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
        $AnimatedSprite.stop()
		
	position += velocity * delta
