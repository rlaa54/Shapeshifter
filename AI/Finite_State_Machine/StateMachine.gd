extends Node

class_name StateMachine

# 여기서 blackboard(게임 상태 저장 객체)를 업데이트함, 

const BlackBoard = preload("../behavior_tree/blackboard.gd")
@onready var blackboard = BlackBoard.new()

@export var initial_state : State

var current_state : State
# 자식 state들을 저장하는 딕셔너리
# 실제 자식들은 State를 상속받은 bt_root 클래스 임
# bt_root는 상태와 행동을 결정하고 판단하는 행동트리를 동시에 가짐
var states : Dictionary = {}
var host : Character_base

func _ready() -> void:
    host = get_parent() # 부모는 캐릭터임
    # 자식들을 가져옴
    for child in get_children():
        # 자식이 State라면
        if child is State:
            # 자식의 이름을 소문자로 바꿔서 딕셔너리에 저장
            states[child.name.to_lower()] = child
            child.Transitioned.connect(on_child_transition)

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
    # blackboard에 현재 턴을 저장함
    blackboard.set_value("turncount", turncount)
    # 자식들을 순회하며 tick()을 호출함
    # 자식들은 상태이자 행동트리임
    for children in get_children():
        children.tick(host, blackboard)

func on_child_transition(state, new_state_name):
    if state != current_state:
        return

    var new_state = states.get(new_state_name.to_lower()) 
    if !new_state:
        return
    
    if current_state:
        current_state.Exit()

    new_state.Enter()

func action_behave(action : Action) -> void:
    if host.canAddAction():
        GameManager.addAction(action)