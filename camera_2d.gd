extends Camera2D

var inputs={"cam_right": Vector2.RIGHT, 
			"cam_left": Vector2.LEFT, 
			"cam_down": Vector2.DOWN, 
			"cam_up": Vector2.UP}

var cam_distance = 150
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			position += inputs[dir] * cam_distance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
