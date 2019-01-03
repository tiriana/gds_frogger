extends Node2D

var screensize
var width = 1920
var height = 1080

export (Array) var LevelScenes = []
export (int) var totalLives = 5
var lives
export (int) var secondsLeft = 300

var score = 0;

var currentLevelNumber = 0
var currentLevel

func _updateSize():
	screensize = get_viewport_rect().size
	var ratioW = screensize.x / width
	var ratioH = screensize.y / height

	var _scale = min(ratioW, ratioH) 

	scale.x = _scale
	scale.y = _scale

func _spawnFrog():
	if (!get_node("Frog")):
		return
	print ("spawning frog");
	$Frog.setBoundries($LeftTop, $BottomRight)
	$Frog.start($Start.position)

func _ready():
	_updateSize()
	
	$Frog.connect("died", self, "_on_frog_died")
	$Frog.connect("won", self, "_on_frog_won")
	
	startLevel(0)
	prepareGame();
	$Frog.isInteractive = false
	
	get_node("UI/MainMenu").connect("start", self, "startGame")
	get_node("UI/GameOver").connect("try_again", self, "restartGame")

func reset():
	pass

func restartGame():
	reset()
	prepareGame()
	startGame()

func prepareGame():
	$Frog.isInteractive = true
	$Frog.visible = true
	setLives(totalLives)
	_spawnFrog()
	$Frog.reset();

func startGame():
	getTimer().start();
	startLevel(1);
	$Frog.isInteractive = true;
	get_node("UI/MainMenu").visible = false;
	get_node("UI/GameOver").visible = false;
	get_node("UI/WinScene").visible = false;
	
func startLevel(levelNumber):
	if (currentLevelNumber >= LevelScenes.size()):
		return
	currentLevelNumber = levelNumber;
	var level = LevelScenes[currentLevelNumber].instance()
	remove_child(currentLevel)
	currentLevel = level;
	add_child(level)
	
	level.connect("finished", self, "_on_level_finished");
	level.connect("score_change", self, "_on_score_change");
	
func goToNextLevel():
	if (currentLevelNumber == LevelScenes.size() - 1):
		goToWinScene()
		return;
	_on_score_change(100);
	startLevel(currentLevelNumber + 1);
	
func getTimer():
	return get_node("UI/RightPanel/Timer")

func goToWinScene():
	get_node("UI/WinScene").show()
	print("THIS IS WIN SCENE")
	getTimer().stop()
	$Frog.isInteractive = false
	$Frog.visible = false
	
func goToGameOver():
	get_node("UI/GameOver").show()
	print("THIS IS GAME OVER SCENE")
	getTimer().stop()
	$Frog.isInteractive = false
	$Frog.visible = false
	
func _on_score_change(score_diff):
	score += score_diff;
	get_node("UI/RightPanel/Score").setScore(score)
	
func _on_level_finished():
	goToNextLevel();
	
func setLives(_lives):
	lives = max(_lives, 0)
	get_node("UI/RightPanel/Lives").setLives(lives)

func _on_frog_died():
	setLives(lives - 1)
	if (lives <= 0):
		goToGameOver();
	else:
		_spawnFrog()
	
func _on_frog_won():
	_spawnFrog()

func _process(delta):
	pass
