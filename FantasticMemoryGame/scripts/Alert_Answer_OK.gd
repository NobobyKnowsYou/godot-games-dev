extends Node2D

func _ready():
	pass

func _on_answerOkAnimation_animation_finished( anim_name ):
	get_parent().continueGame()
	queue_free()
