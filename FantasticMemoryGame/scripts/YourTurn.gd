extends Node2D

func _ready():
	pass

func _on_urTurnAnimation_animation_finished( anim_name ):
	get_parent().isPlay = true
	queue_free()
