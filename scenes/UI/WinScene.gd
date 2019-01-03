extends Node2D
signal play_again

func _ready():
	$Label.setText("!!! YOU WON !!!");
	pass


func _on_Play_again_pressed():
	emit_signal("play_again");
	pass # replace with function body
