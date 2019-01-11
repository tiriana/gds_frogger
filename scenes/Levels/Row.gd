extends Node2D

func getRowLength():
	var minX = 50000
	var maxX = -50000
	for child in get_children():
		if (child.position.x < minX):
			minX = child.position.x
		if (child.position.x > maxX):
			maxX = child.position.x
	
	return maxX - minX

func setRowBoundaries():
	var minX = 50000
	var maxX = -50000
	for child in get_children():
		if (child.position.x < minX):
			minX = child.position.x
		if (child.position.x > maxX):
			maxX = child.position.x
	
	for child in get_children():
		child.minX = minX - 756 / 2
		child.maxX = maxX + 756 / 2
		
func duplicateChilden():
	var length = getRowLength()
	for child in get_children():
		var copy = child.clone()
		add_child(copy);
		copy.position.x += length + 756

func _ready():
	duplicateChilden();
	setRowBoundaries()
	pass
