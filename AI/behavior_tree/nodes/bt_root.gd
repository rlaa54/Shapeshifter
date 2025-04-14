@icon("res://Asset/Art/icons/behavior_tree/tree.svg")

extends Behavior_tree

class_name Bt_root

# Bt_root의 자식은 행동트리이고 본인은 상태임.
# 결정하고 행동할 때 마다 자식의 tick()을 호출합니다. 
# 오직 하나의 자식만 가져야 함.

@export var enabled : bool = true
var host : Character_base

# @onready var actor = $"../.."

# var blackboard : Blackboard = null

# func set_blackboard(_blackboard : Blackboard) -> void:
#     blackboard = _blackboard
func _ready():
    # 루트의 부모는 state_machine임
    host = get_parent().host
    if self.get_child_count() != 1:
        print("Behavior Tree error: Root should have one child")
        disable()

func tick(actor, blackboard):
    # 오직 하나의 첫번째 자식만 호출함
    if get_child(0).tick(actor, blackboard) == SUCCESS:
        pass


func enable():
    self.enabled = true

func disable():
    self.enabled = false