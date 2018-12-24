extends Node2D

var isFull = false;

func markAsFull():
	isFull = true;
	$Frog.visible = true;
	$StaticBody2D.isDanger = true
	$StaticBody2D.isHome = false
	
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
