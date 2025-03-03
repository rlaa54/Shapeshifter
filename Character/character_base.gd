extends CharacterBody2D

class_name Character_base

@export var stats : Basic_stat

var nextAction : Action

func _ready():
	stats._ready()

func get_action() -> Action:
	var action = nextAction
	# only perform once
	nextAction = null
	return action

func setNextAction(action: Action) -> void:
	nextAction = action