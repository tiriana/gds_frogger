extends Node2D

export (int) var totalSeconds = 300
var secondsLeft
var isRunnig = false

func setSecondsTotal(_seconds):
	totalSeconds = _seconds
	
func setSecondsLeft(_seconds):
	secondsLeft = _seconds
	$Label.setText("Time: " + str(int(secondsLeft)));
	
func start():
	isRunnig = true
	
func stop():
	isRunnig = false

func _ready():
	setSecondsLeft(totalSeconds);
	pass
	
func _process(delta):
	if (!isRunnig):
		return;
	setSecondsLeft(secondsLeft - delta)
	pass
