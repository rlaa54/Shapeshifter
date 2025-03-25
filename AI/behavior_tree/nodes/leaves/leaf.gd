extends Bt_node

class_name Leaf

func _ready() -> void:
    if self.get_child_count() != 0:
        print("BehaviorTree error: Leaf %s should not have children" % self.name)