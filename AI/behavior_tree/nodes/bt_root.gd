@icon("res://Asset/Art/behavior_tree/icons/tree.svg")

extends Behavior_tree

class_name Bt_root

# Bt_root는 최상위 노드로, 하위 노드 1개만 두고, 
# 매 프레임마다 자식의 tick()을 호출합니다. 
# 여기서 blackboard(게임 상태 저장 객체)를 매 프레임에 업데이트하거나, 
# delta(프레임 시간) 등을 전달할 수 있습니다.

const Blackboard = preload("../blackboard.gd")

@export var enabled : bool = true

@onready var blackboard = Blackboard.new()

func _ready():
    if self.get_child_count() != 1:
        print("Behavior Tree error: Root should have one child")
        disable()
        return

func _physics_process(delta: float) -> void:
    if not enabled:
        return

    blackboard.set_value("delta", delta)

    self.get_child(0).tick(get_parent(), blackboard)

func enable():
    self.enabled = true

func disable():
    self.enabled = false