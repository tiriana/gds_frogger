extends TextureButton

func _ready():
	$exitSound.connect("finished", self, "quit");
	pass
	
func _on_BaseButton_pressed():
	$exitSound.play();

func quit():
	get_tree().quit();

func _on_BaseButton_mouse_entered():
	$hoverSound.play();
	pass # replace with function body


func _on_BaseButton_mouse_exited():
	$hoverSound.play();
	pass # replace with function body
