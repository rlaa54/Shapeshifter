extends Bt_node

class_name Decorator

func _ready() -> void:
    if self.get_child_count() != 1:
        print("BehaviorTree error: Decorator %s should have only one child" % self.name)