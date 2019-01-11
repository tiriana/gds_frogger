extends TextureButton

func _ready():
	pass


func _on_BaseButton_pressed():
	$clickSound.play();
	pass # replace with function body

func _on_BaseButton_mouse_entered():
	$hoverSound.play();
	pass # replace with function body


func _on_BaseButton_mouse_exited():
	$hoverSound.play();
	pass # replace with function body
