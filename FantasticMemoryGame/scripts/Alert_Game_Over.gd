extends Node2D

onready var pvt = get_node("../Player_View_Thumb/playerViewThumbs")

func _ready():
	pass

func _on_ENDAnimation_animation_finished( anim_name ):
	pvt.play("moveThumbs")
	queue_free()
