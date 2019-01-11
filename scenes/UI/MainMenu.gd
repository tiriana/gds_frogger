extends Node2D
signal start

func _on_BaseButton_pressed():
	emit_signal("start");
	pass # replace with function body
