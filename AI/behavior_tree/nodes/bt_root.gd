@icon("res://Asset/Art/icons/behavior_tree/tree.svg")

extends Behavior_tree

class_name Bt_root

# Bt_root는 최상위 노드로, 하위 노드 1개만 두고, 
# 결정하고 행동할 때 마다 자식의 perform()을 호출합니다. 

@export var enabled : bool = true

# @onready var actor = $"../.."

# var blackboard : Blackboard = null

# func set_blackboard(_blackboard : Blackboard) -> void:
#     blackboard = _blackboard

func _ready():
    # if self.get_child_count() != 1:
    #     print("Behavior Tree error: Root should have one child")
        disable()

func enable():
    self.enabled = true

func disable():
    self.enabled = false