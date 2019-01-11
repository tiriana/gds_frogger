extends Node2D
signal play_again

func _on_Play_again_pressed():
	emit_signal("play_again");
	pass # replace with function body
