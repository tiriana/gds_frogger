extends Node2D

func setLives(lives):
	$Label.setText("Lives: " + str(lives));

func _ready():
	pass
