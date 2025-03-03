extends Action

class_name WalkAction

enum Direction { NW, N, NE, W, E, SW, S, SE, NONE }

var dir : Direction

func _init(pDir) -> void:
	dir = pDir