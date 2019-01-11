extends Node2D
signal play_again

func enterScene():
	print("Win secne")
	show();
	$winSound.play();
	$winSound.connect("finished", self, "playMusic")
	$music.connect("finished", self, "playMusic")
	pass
	
func playMusic():
	$music.play();
	
func exitScene():
	hide();
	$music.stop()
	$winSound.top();
	pass

func _on_Play_again_pressed():
	emit_signal("play_again");
	pass # replace with function body
