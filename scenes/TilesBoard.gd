extends Node

export (int) var rowsNum = 12
export (int) var colsNum = 14

var rows = []

func get_tile(rowNum):
	if rowNum == 0:
		return "Grass"
	if rowNum >= rowsNum - 2:
		return "Grass"
	var mid = int(rowsNum / 2) - 1
	if rowNum == mid:
		return "Grass"
	if rowNum < mid:
		return "Asphalt"
	return "Water"

func create_cells():
	for rowNum in range(rowsNum - 1):
		for colNum in range(colsNum):
			$TileMap.set_cell(colNum, rowsNum - rowNum -2, $TileMap.tile_set.find_tile_by_name(get_tile(rowNum)));
			
func _ready():
	create_cells()
	pass
