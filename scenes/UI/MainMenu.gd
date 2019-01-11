extends Node2D
signal start

func enterScene():
	show();
	playMusic();
	$music.connect("finished", self, "playMusic")
	pass
	
func playMusic():
	$music.play();
	
func exitScene():
	hide();
	$music.stop()
	pass

func _on_BaseButton_pressed():
	emit_signal("start");
	pass # replace with function body
