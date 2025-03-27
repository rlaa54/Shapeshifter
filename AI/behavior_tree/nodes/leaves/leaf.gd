@icon("res://Asset/Art/icons/behavior_tree/action.svg")

extends Bt_node

class_name Leaf

# 실제 '행동' 또는 '조건' 구현을 위한 클래스

func _ready() -> void:
    if self.get_child_count() != 0:
        print("BehaviorTree error: Leaf %s should not have children" % self.name)