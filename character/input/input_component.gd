extends Node2D

class_name Input_component

@export var character : Character_base

@onready var tile_map_layer = $"/root/World/TileMapLayer"

enum Direction { NW, N, NE, W, E, SW, S, SE, NONE }

var click_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("NW_move"):
		move(Direction.NW)

func move(dir: Direction) -> void:
	GameManager.pc.setNextAction(new WalkAction(dir))