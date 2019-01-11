extends Node2D
signal finished
signal score_change

export (int) var checkpointPoints = 10
export (int) var finishedPoints = 100
export (int) var time = 90

var checkpointLenght = 72;
var nextCheckpoint = checkpointLenght;

func _ready():
	$Board.visible = false
	$Homes.connect("all_homes_filled", self, "_on_all_homes_filled")
	$Homes.connect("home_filled", self, "_on_home_filled")
	pass

func onFrogProgress(frogProgress):
	if frogProgress > nextCheckpoint:
		nextCheckpoint += checkpointLenght
		emit_signal("score_change", checkpointPoints, 0);
	
func _on_all_homes_filled():
	emit_signal("finished");
	emit_signal("score_change", finishedPoints, 0);
	
func _on_home_filled():
	emit_signal("score_change", 50, 10)
	nextCheckpoint = checkpointLenght