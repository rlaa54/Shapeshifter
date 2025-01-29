extends Camera2D

var inputs={"cam_right": Vector2.RIGHT, 
			"cam_left": Vector2.LEFT, 
			"cam_down": Vector2.DOWN, 
			"cam_up": Vector2.UP}

@export var cam_speed = 2500
@export var zoom_distance = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		zoom += Vector2(zoom_distance, zoom_distance)
	if event.is_action_pressed("zoom_out"):
		if zoom.x >= zoom_distance and zoom.y >= zoom_distance:
			zoom -= Vector2(zoom_distance, zoom_distance)
	

func _process(delta: float) -> void:
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			position += inputs[dir] * cam_speed * delta