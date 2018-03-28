extends Node
tool # allow to use this code in Project > Settings > AutoLoad

################################### VARS
# levels type:: 1 Easy, 2 Moderate, 3 Hard
var level = 1 
var memo = true
var gameSizeSequence = 5
var sizeOfHints = 3
################################### SETS/GETS

func set_level(level):
	level = level

func get_level():
	return level

func set_memo(memo):
	memo = memo

func get_memo():
	return memo

func set_gameSizeSequence(size):
	gameSizeSequence = size

func get_gameSizeSequence():
	return gameSizeSequence

func set_sizeHint(Hint):
	sizeOfHints = Hint

func get_sizeHint():
	return sizeOfHints

################################### TRICK TOOL
# Remove accumulated internals Nodes of specific Node
func removeAllNodes(node):
    for N in node.get_children():
        N.queue_free()
