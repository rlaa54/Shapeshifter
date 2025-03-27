@icon("res://Asset/Art/icons/behavior_tree/category_decorator.svg")

extends Bt_node

class_name Decorator

# 단 하나의 자식만 감싸서, 
# tick 결과를 반전시키거나(failer, inverter, succeder),
# 제한 조건을 걸거나(limiter)
# 등의 용도로 사용함

func _ready() -> void:
    if self.get_child_count() != 1:
        print("BehaviorTree error: Decorator %s should have only one child" % self.name)