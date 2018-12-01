extends Node2D

var screensize
var width = 1920
var height = 1080

func _updateSize():
	screensize = get_viewport_rect().size
	var ratioW = screensize.x / width
	var ratioH = screensize.y / height
	
	var _scale = min(ratioW, ratioH) - 0.1
	
	scale.x = _scale
	scale.y = _scale

func _startFrog():
	$Frog.start($Start.position)

func _ready():
	_updateSize()
	_startFrog()
	
	$Frog.connect("hit", self, "_on_frog_hit")
	
func _on_frog_hit():
	_startFrog()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
