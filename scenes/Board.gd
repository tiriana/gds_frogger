extends Node2D

export (int) var rowsNum = 12
export (int) var colsNum = 14

var rows = []

export (float) var cellSize = 20.0

export (PackedScene) var GrassTile
export (PackedScene) var RoadTile
export (PackedScene) var WaterTile
export (PackedScene) var WinTile

func get_tile(rowNum):
	if rowNum == 0:
		return GrassTile
	if rowNum >= rowsNum - 1:
		return GrassTile
	var mid = int(rowsNum / 2)
	if rowNum == mid:
		return GrassTile
	if rowNum < mid:
		return RoadTile
	return WaterTile

func create_cells():
	for rowNum in range(rowsNum):
		rows.append([])
		for colNum in range(colsNum):
			var child = get_tile(rowNum).instance()
			rows[rowNum].append(child)
			add_child(child)

func _ready():
	create_cells()
	print(rows)
	pass

#func _process(delta):
#	pass
