extends CharacterBody2D

var tile_size = 64
var inputs={"Right": Vector2.RIGHT, 
			"Left": Vector2.LEFT, 
			"Down": Vector2.DOWN, 
			"Up": Vector2.UP}

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2

func _unhandled_input(event: InputEvent) -> void:
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	position += inputs[dir] * tile_size