extends Node2D
signal all_homes_filled
signal home_filled

var homesNum = 0

func _ready():
	homesNum = 0;
	for home in get_children():
		homesNum += 1
		home.connect("filled", self, "_on_home_filled")
	pass
	
func _on_home_filled():
	emit_signal("home_filled")
	homesNum -= 1
	if (homesNum <= 0):
		emit_signal("all_homes_filled")
