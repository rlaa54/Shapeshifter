extends Node

class_name StateMachine

# 여기서 blackboard(게임 상태 저장 객체)를 업데이트함, 

const BlackBoard = preload("../behavior_tree/blackboard.gd")
@onready var blackboard = BlackBoard.new()

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

func _ready() -> void:
    for child in get_children():
        if child is State:
            states[child.name.to_lower()] = child
            child.Transitioned.connect(on_child_transition)
            # child.set_blackboard(blackboard)

    if initial_state:
        initial_state.Enter()
        current_state = initial_state

# func _process(delta: float) -> void:
#     if current_state:
#         current_state.Update(delta)

# func _physics_process(delta: float) -> void:
#     if current_state:
#         current_state.Physics_Update(delta)

# 플레이어 인풋이 끝남 시점에 호출되어야 함
func decision_and_behavior(turncount : float) -> void:
    var children = get_children()
    blackboard.set_value("turncount", turncount)

func on_child_transition(state, new_state_name):
    if state != current_state:
        return

    var new_state = states.get(new_state_name.to_lower()) 
    if !new_state:
        return
    
    if current_state:
        current_state.Exit()

    new_state.Enter()