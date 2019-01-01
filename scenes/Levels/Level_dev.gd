extends Node2D
signal finished

func _ready():
	$Homes.connect("all_homes_filled", self, "_on_all_homes_filled")
	pass
	
func _on_all_homes_filled():
	emit_signal("finished");
