extends CharacterBody2D

class_name Character_base

@export var stats : Basic_stat

var nextAction : Action = null

func _ready():
	stats._ready()

	# 생성되면 GameManager에 등록
	GameManager.characters.append(self)

func get_action() -> Action:
	var action = nextAction
	# only perform once
	nextAction = null
	return action

func setNextAction(action: Action) -> void:
	nextAction = action
