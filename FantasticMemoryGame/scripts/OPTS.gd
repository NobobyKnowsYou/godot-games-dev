extends Node2D

func _ready():
	# OPTS ready
	pass

func _on_BttCloseOPTS_pressed():
	get_tree().paused = false
	set("visible",false)

func _on_Btt_MEMO_pressed():
	var isPressed = get_node("panelOpt/memoryOPT/Btt_MEMO").get("pressed")
	Tools.set_memo( isPressed )
#	print(Tools.get_memo())

func _on_Btt_EASY_pressed():
	#print("Easy toggle")
	Tools.set_level(1)
	Tools.set_gameSizeSequence(5)
	Tools.set_sizeHint(3)
#		print(Tools.get_level())
	get_node("panelOpt/SkillsOPT/Btt_EASY").set("pressed",true)
	get_node("panelOpt/SkillsOPT/Btt_MEDIUM").set("pressed",false)
	get_node("panelOpt/SkillsOPT/Btt_HARD").set("pressed",false)
	
	get_node("panelOpt/memoryOPT/Btt_MEMO").set("pressed",true)
	get_node("panelOpt/memoryOPT/Btt_MEMO").set("disabled",false)
	Tools.set_memo( true )

func _on_Btt_MEDIUM_pressed():
#	print("moderate toggle")
	Tools.set_level(2)
	Tools.set_gameSizeSequence(10)
	Tools.set_sizeHint(3)
#	print(Tools.get_level())
	get_node("panelOpt/SkillsOPT/Btt_EASY").set("pressed",false)
	get_node("panelOpt/SkillsOPT/Btt_MEDIUM").set("pressed",true)
	get_node("panelOpt/SkillsOPT/Btt_HARD").set("pressed",false)
	
	get_node("panelOpt/memoryOPT/Btt_MEMO").set("pressed",false)
	get_node("panelOpt/memoryOPT/Btt_MEMO").set("disabled",false)
	Tools.set_memo( false )
	
func _on_Btt_HARD_pressed():
#	print("hard toggle")
	Tools.set_level(3)
	Tools.set_gameSizeSequence(20)
	Tools.set_sizeHint(5)
#	print(Tools.get_level())
	get_node("panelOpt/SkillsOPT/Btt_EASY").set("pressed",false)
	get_node("panelOpt/SkillsOPT/Btt_MEDIUM").set("pressed",false)
	get_node("panelOpt/SkillsOPT/Btt_HARD").set("pressed",true)
	
	get_node("panelOpt/memoryOPT/Btt_MEMO").set("pressed",false)
	get_node("panelOpt/memoryOPT/Btt_MEMO").set("disabled",true)
	Tools.set_memo( false )

func _on_Btt_Sound_pressed():
	pass
