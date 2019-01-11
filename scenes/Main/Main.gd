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
	randomize();
	_updateSize()
	
	$Frog.connect("died", self, "_on_frog_died")
	$Frog.connect("won", self, "_on_frog_won")
	
	startLevel(0)
	prepareGame();
	$Frog.isInteractive = false
	
	get_node("UI/MainMenu").enterScene();
	get_node("UI/MainMenu").connect("start", self, "startGame")
	get_node("UI/GameOver").connect("try_again", self, "restartGame")
	get_node("UI/WinScene").connect("play_again", self, "restartGame")
	getTimer().connect("timeout", self, "goToGameOver")

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
	setScore(0);
	_spawnFrog()
	$Frog.reset();

func startGame():
	getTimer().start();
	startMusic();
	startLevel(0);
	$Frog.isInteractive = true;
	get_node("UI/MainMenu").exitScene();
	get_node("UI/GameOver").exitScene();
	get_node("UI/WinScene").exitScene();
	
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
	getTimer().setSecondsLeft(level.time)
	
func goToNextLevel():
	if (currentLevelNumber == LevelScenes.size() - 1):
		goToWinScene()
		return;
	startLevel(currentLevelNumber + 1);
	$levelFinishedMusic.play();
	
func getTimer():
	return get_node("UI/RightPanel/Timer")

func goToWinScene():
	if get_node("UI/WinScene").visible:
		return;
	stopMusic();
	get_node("UI/WinScene").enterScene()
	getTimer().stop()
	$Frog.isInteractive = false
	$Frog.visible = false
	
func startMusic():
	playMusic();
	$levelMusic.connect("finished", self, "playMusic")
	
func playMusic():
	$levelMusic.play();
	
func stopMusic():
	$levelMusic.stop();
	
func goToGameOver():
	if get_node("UI/GameOver").visible:
		return;
	stopMusic();
	get_node("UI/GameOver").enterScene()
	getTimer().stop()
	$Frog.isInteractive = false
	$Frog.visible = false
	
func _on_score_change(score_diff, for_every_second):
	print ("_on_score_change ", score_diff, " ", for_every_second)
	setScore(score + score_diff + for_every_second * getTimer().secondsLeft)

func setScore(_score):
	score = round(_score);
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
	if $Frog.isInteractive and currentLevel:
		currentLevel.onFrogProgress($Start.position.y - $Frog.position.y)
	pass
