extends Node2D

func _ready():
	pass

func _on_BttOK_pressed():
	get_tree().paused = false
	get_node(".").queue_free()
