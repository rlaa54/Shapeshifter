extends Bt_node

class_name Composite

func _ready() -> void:
    if self.get_child_count() < 1:
        print("BehaviorTree error: Composite %s should have at least one child" %self.name)