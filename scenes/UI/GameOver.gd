extends Node2D
signal try_again

func _on_TryAgain_pressed():
	emit_signal("try_again");
	pass # replace with function body
