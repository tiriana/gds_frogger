extends Node2D
signal start

func _ready():
	$Label.setText("TAKA SOBIE ZABA");
	pass


func _on_BaseButton_pressed():
	emit_signal("start");
	pass # replace with function body
