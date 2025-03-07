extends Node2D

class_name Input_component

@export var character : Character_base

@onready var tile_map_layer = $"/root/World/TileMapLayer"

var click_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("NW_move"):
		move(GameManager.Direction.NW)
	if event.is_action_pressed("N_move"):
		move(GameManager.Direction.N)
	if event.is_action_pressed("NE_move"):
		move(GameManager.Direction.NE)
	if event.is_action_pressed("W_move"):
		move(GameManager.Direction.W)
	if event.is_action_pressed("E_move"):
		move(GameManager.Direction.E)
	if event.is_action_pressed("SW_move"):
		move(GameManager.Direction.SW)
	if event.is_action_pressed("S_move"):
		move(GameManager.Direction.S)
	if event.is_action_pressed("SE_move"):
		move(GameManager.Direction.SE)

func move(dir: GameManager.Direction) -> void:
	GameManager.pc.setNextAction(WalkAction.new(dir))