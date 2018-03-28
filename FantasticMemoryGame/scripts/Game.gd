extends Node2D

# GAME VARS ####################################################################
var arrayGame
var arrayPlayer
var sizeOfArrayInitGame = 0
var bttNumAnimation = 0
var thumbNextPos = 0
var thumbChildId
var isPlay = false
var isVictory = false
var victoryPlayerGUI
var hintSize = Tools.get_sizeHint()

# Game Buttons 
onready var btt1 = load("res://scenes/Thumb_Btt_1.tscn")
onready var btt2 = load("res://scenes/Thumb_Btt_2.tscn")
onready var btt3 = load("res://scenes/Thumb_Btt_3.tscn")
onready var btt4 = load("res://scenes/Thumb_Btt_4.tscn")

# Options
onready var OPTS = get_node("OPTS")
onready var opt_btt_memo = get_node("OPTS/panelOpt/memoryOPT/Btt_MEMO")
onready var opt_btt_sound = get_node("OPTS/panelOpt/soundOPT/Btt_Sound")

# Alerts
onready var alertStartGame = load("res://scenes/Alert_Init.tscn")
onready var alertYourTurn = load("res://scenes/Alert_Your_Turn.tscn")
onready var alertAnswerOk = load("res://scenes/Alert_Answer_OK.tscn")
onready var alertGameOver = load("res://scenes/Alert_Game_Over.tscn")
onready var alertVictory = load("res://scenes/Alert_Victory.tscn")

# Sounds
onready var sound1 = get_node("Sounds/PlaySound1")
onready var sound2 = get_node("Sounds/PlaySound2")
onready var sound3 = get_node("Sounds/PlaySound3")
onready var sound4 = get_node("Sounds/PlaySound4")

# Generals
onready var bttAnimation = get_node("BttAnimatic/BttAnimationPlayer")
onready var labelSize = get_node("TopINFO/Display_Game/Size_Limits")
onready var labelTips = get_node("TopINFO/Display_Tips/Size_Tips")
onready var bttHint = get_node("base/Button_HINT")
onready var View_Thumbs = get_node("Game_View_Thumb")
onready var View_Player = get_node("Player_View_Thumb")

# GAME FUNCTIONS ###############################################################

func _ready():
	arrayGame = Array()
	thumbChildId = Array()
	bttHint.set("disabled",true)
	set_process(true)
	get_tree().paused = true

func _process(delta):
	labelSize.set("text",str(arrayGame.size())+"/"+str(Tools.get_gameSizeSequence()))
	labelTips.set("text",str(hintSize))
	
	# avoid Player click while animation 'isPlay'ing
	if isPlay:
		get_node("buttons/Button1").set("disabled", false)
		get_node("buttons/Button2").set("disabled", false)
		get_node("buttons/Button3").set("disabled", false)
		get_node("buttons/Button4").set("disabled", false)
	else:
		get_node("buttons/Button1").set("disabled", true)
		get_node("buttons/Button2").set("disabled", true)
		get_node("buttons/Button3").set("disabled", true)
		get_node("buttons/Button4").set("disabled", true)
	
	if opt_btt_sound.get("pressed"):
		get_node("TopINFO/Display_Sound/Actual_SFX").set("text","On")
		sound1.set("max_distance", 1000)
		sound2.set("max_distance", 1000)
		sound3.set("max_distance", 1000)
		sound4.set("max_distance", 1000)
	else:
		get_node("TopINFO/Display_Sound/Actual_SFX").set("text","Off")
		sound1.set("max_distance", 1)
		sound2.set("max_distance", 1)
		sound3.set("max_distance", 1)
		sound4.set("max_distance", 1)

# BTT MENU ###
func _on_Button_INI_pressed():
	# inner vars
	arrayGame = Array()
	arrayPlayer = Array()
	sizeOfArrayInitGame = 3
	bttNumAnimation = 0
	thumbNextPos = 0
	
	if isVictory:
		remove_child(victoryPlayerGUI)
		isVictory = false
	
	# show HINT THUMBS if on
	clearThumbs()
	View_Thumbs.set("visible", opt_btt_memo.get("pressed"))
	View_Player.set("visible", opt_btt_memo.get("pressed"))
	
	# random numbers and populate the array to start a game
	for i in sizeOfArrayInitGame:
		randomize()
		var r = int(rand_range(1,5))
		if Tools.get_level() > 0:
			while r == arrayGame.back():
				randomize()
				r = int(rand_range(1,5))
		# insert value into arrayGame
		arrayGame.push_back(r)

	# show Start Game alert
	alertStartGame()

func _on_Button_HINT_pressed():
	if hintSize > 0:
#		print("# Hint")
		isPlay = false
		bttHint.set("disabled",true)
		arrayPlayer = Array()
		bttNumAnimation = 0
		clearThumbs()
		bttAnimation.play("playBtt_"+str(arrayGame[bttNumAnimation]))
		hintSize = hintSize-1

# SHOW OPTIONS ###
func _on_Button_OPT_pressed():
	#print("OPTS closed")
	get_tree().paused = true
	get_node("OPTS").set("visible",true)

################################################################# 
# Animated buttons sequence based on arrayGame values
func _on_BttAnimationPlayer_animation_finished( anim_name ):
	var animNum = int(anim_name.substr(8,1))
	var thisBtt
	
	# increment num
	bttNumAnimation = int(bttNumAnimation)+1
	
	if bttNumAnimation < arrayGame.size():
		if animNum == 1:
			thisBtt = btt1.instance()
		if animNum == 2:
			thisBtt = btt2.instance()
		if animNum == 3:
			thisBtt = btt3.instance()
		if animNum == 4:
			thisBtt = btt4.instance()
		
		thumbChildId.append(thisBtt)
		thumbNextPos = int(thumbNextPos)+1
		
		var pos = get_node("Game_View_Thumb/thumb_init_pos_"+str(thumbNextPos))
		pos.add_child(thisBtt)
		
		# play sequence
		bttAnimation.play("playBtt_"+str(arrayGame[bttNumAnimation]))
	else:
		bttHint.set("disabled",false) # DICA ABERTA
		if animNum == 1:
			thisBtt = btt1.instance()
		if animNum == 2:
			thisBtt = btt2.instance()
		if animNum == 3:
			thisBtt = btt3.instance()
		if animNum == 4:
			thisBtt = btt4.instance()
		
		thumbNextPos = int(thumbNextPos)+1
		var pos = get_node("Game_View_Thumb/thumb_init_pos_"+str(thumbNextPos))
		pos.add_child(thisBtt)
		###
		thumbNextPos = 0
		get_node("Game_View_Thumb/ThumbsTimer").start()


# when finish anim is Player time
func _on_ThumbsTimer_timeout():
	clearThumbs()
	## player turn
	alertYourTurn()


# Remove all internal nodes of a node
func clearThumbs():
	for i in 20:
		var ii = i+1
		Tools.removeAllNodes(get_node("Game_View_Thumb/thumb_init_pos_"+str(ii)))
		Tools.removeAllNodes(get_node("Player_View_Thumb/thumb_init_pos_"+str(ii)))

# Game rules validations
func validateRules():
	if arrayPlayer.size() == arrayGame.size():
		isPlay = false
		var checking = 0
		for i in arrayPlayer.size():
			if int(arrayPlayer[i]) == int(arrayGame[i]):
				checking=checking+1
		# if end of game 
		# else continue...
		if checking == arrayGame.size():
			if checking == Tools.get_gameSizeSequence():
				### alertVictory
				victoryPlayerGUI = alertVictory.instance()
				add_child(victoryPlayerGUI)
				bttHint.set("disabled",true)
				isVictory = true
			else:
				###### CONTINUE ########
				bttNumAnimation = 0
				thumbNextPos = 0
				clearThumbs()
				# add new random value to array
				randomize()
				var r = int(rand_range(1,5))
				arrayGame.push_back(r)
				add_child(alertAnswerOk.instance())
		else:
			###### END OF GAME ########
			var endGame = alertGameOver.instance()
			add_child(endGame)
			isPlay = false
			var h = get_node("base/Button_HINT")
			h.set("disabled",true)
			var numTh = 1
			var thisBtt
			for th in arrayGame:
				if th == 1:
					thisBtt = btt1.instance()
				if th == 2:
					thisBtt = btt2.instance()
				if th == 3:
					thisBtt = btt3.instance()
				if th == 4:
					thisBtt = btt4.instance()
				get_node("Game_View_Thumb/thumb_init_pos_"+str(numTh)).add_child(thisBtt)
				numTh=numTh+1


################################################ ALERTS

func alertStartGame():
	var ini = alertStartGame.instance()
	add_child(ini)

func continueGame():
	arrayPlayer = Array()
	bttAnimation.play("playBtt_"+str(arrayGame[bttNumAnimation]))

func alertYourTurn():
	var vez = alertYourTurn.instance()
	add_child(vez)
	thumbNextPos = 0

func addPositionPlayer(newBtt):
	thumbNextPos=thumbNextPos+1
	var pos = get_node("Player_View_Thumb/thumb_init_pos_"+str(thumbNextPos))
	pos.add_child(newBtt)

################################ PLAY BUTTONS

func _on_Button1_pressed():
	arrayPlayer.push_back(1)
	addPositionPlayer(btt1.instance())
	sound1.play()
	validateRules()

func _on_Button2_pressed():
	arrayPlayer.push_back(2)
	addPositionPlayer(btt2.instance())
	sound2.play()
	validateRules()

func _on_Button3_pressed():
	arrayPlayer.push_back(3)
	addPositionPlayer(btt3.instance())
	sound3.play()
	validateRules()

func _on_Button4_pressed():
	arrayPlayer.push_back(4)
	addPositionPlayer(btt4.instance())
	sound4.play()
	validateRules()
	
#####################################################

# Close OPTIONS
func _on_BttCloseOPTS_pressed():
	get_tree().paused = false
	get_node("Alerts/OPTS").set("visible",false)

# Quit Game after confirm
func _on_Button_QUIT_pressed():
	get_node("Alerts/ConfirmationDialog").show()

func _on_ConfirmationDialog_confirmed():
	get_tree().quit()

