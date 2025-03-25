@icon("res://Asset/Art/behavior_tree/icons/action.svg")

extends Bt_node

class_name Leaf

# 실제 '행동' 또는 '조건' 구현

func _ready() -> void:
    if self.get_child_count() != 0:
        print("BehaviorTree error: Leaf %s should not have children" % self.name)