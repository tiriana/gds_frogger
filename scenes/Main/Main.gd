extends Node2D

var screensize
var width = 1920
var height = 1080

export (PackedScene) var Level

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
	
	$Frog.connect("died", self, "_on_frog_died")
	$Frog.connect("won", self, "_on_frog_won")
	
	var level = Level.instance()
	add_child(level)
	
func _on_frog_died():
	_startFrog()
	
func _on_frog_won():
	_startFrog()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
