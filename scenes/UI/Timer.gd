extends Node2D
signal timeout;

export (int) var totalSeconds = 300
var secondsLeft
var isRunnig = false

func setSecondsTotal(_seconds):
	totalSeconds = _seconds
	
func setSecondsLeft(_seconds):
	secondsLeft = _seconds
	$Label.text = "Time: " + str(int(secondsLeft))
	
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
	if secondsLeft <= 0:
		emit_signal("timeout");
		stop();
	pass
