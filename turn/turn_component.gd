extends Node2D

class_name Turn_component

func _ready() -> void:
	print("Turn component ready!")
	print(TurnManager.turn_started)
	TurnManager.turn_started.connect(_on_turn_started)

func _on_turn_started(current_entity: String) -> void:
	print("Received turn start signal for: " + str(current_entity))
