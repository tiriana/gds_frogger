extends Node2D
signal try_again

func enterScene():
	show();
	$loseSound.play();
	$loseSound.connect("finished", self, "playMusic")
	$music.connect("finished", self, "playMusic")
	pass
	
func playMusic():
	$music.play();
	
func exitScene():
	hide();
	$music.stop()
	$loseSound.stop();
	pass

func _on_TryAgain_pressed():
	emit_signal("try_again");
	pass # replace with function body
