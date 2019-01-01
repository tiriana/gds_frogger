extends Node2D

var screensize
var width = 1920
var height = 1080

export (Array) var LevelScenes = []
export (int) var lives = 5
export (int) var secondsLeft = 300

var currentLevelNumber = 0
var currentLevel

func _updateSize():
	screensize = get_viewport_rect().size
	var ratioW = screensize.x / width
	var ratioH = screensize.y / height

	var _scale = min(ratioW, ratioH) 

	scale.x = _scale
	scale.y = _scale

func _startFrog():
	$Frog.start($Start.position)

func _ready():
	_updateSize()
	_startFrog()
	
	$Frog.connect("died", self, "_on_frog_died")
	$Frog.connect("won", self, "_on_frog_won")
	
	startLevel(0);
	
func startLevel(levelNumber):
	if (currentLevelNumber >= LevelScenes.size()):
		return
	currentLevelNumber = levelNumber;
	var level = LevelScenes[currentLevelNumber].instance()
	remove_child(currentLevel)
	currentLevel = level;
	add_child(level)
	
	level.connect("finished", self, "_on_level_finished");
	
func goToNextLevel():
	if (currentLevelNumber == LevelScenes.size() - 1):
		goToWinScene()
		return;
	startLevel(currentLevelNumber + 1);
	
func goToWinScene():
	print("THIS IS WIN SCENE")
	
func goToGameOver():
	print("THIS IS GAME OVER SCENE")
	
func _on_level_finished():
	goToNextLevel();

func _on_frog_died():
	_startFrog()
	
func _on_frog_won():
	_startFrog()

func clampFrog():
	$Frog.position.x = clamp($Frog.position.x, $LeftTop.position.x + 36, $BottomRight.position.x - 36)
	$Frog.position.y = clamp($Frog.position.y, $LeftTop.position.y + 36, $BottomRight.position.y - 36)

func _process(delta):
	clampFrog();
	pass
