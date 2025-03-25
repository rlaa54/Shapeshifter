@icon("res://Asset/Art/behavior_tree/icons/category_composite.svg")

extends Bt_node

class_name Composite

# 여러 자식 노드를 순회할 때, sequence(모든 자식이 순차 SUCCESS를 만족해야 SUCCESS), 
# selector(어느 한 자식이나 특정 조건 충족 시 SUCCESS) 등의 방식을 구현함

func _ready() -> void:
    if self.get_child_count() < 1:
        print("BehaviorTree error: Composite %s should have at least one child" %self.name)