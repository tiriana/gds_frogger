extends Node2D

var screensize
var width = 1920
var height = 1080

func _ready():
	screensize = get_viewport_rect().size
	var ratioW = screensize.x / width
	var ratioH = screensize.y / height
	
	var _scale = min(ratioW, ratioH) - 0.1;
	
	scale.x = _scale
	scale.y = _scale
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
