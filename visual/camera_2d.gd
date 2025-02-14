extends Camera2D

var inputs={"cam_right": Vector2.RIGHT, 
			"cam_left": Vector2.LEFT, 
			"cam_down": Vector2.DOWN, 
			"cam_up": Vector2.UP}

@export var cam_speed = 2500
@export var zoom_distance = 0.2
@export var zoom_max = 2.0
@export var zoom_min = 0.6

@onready var tile_map_layer = $"/root/World/TileMapLayer"
@onready var cell_size = tile_map_layer.cell_size
@onready var num_tiles = tile_map_layer.num_tiles

var viewport_width = ProjectSettings.get("display/window/size/viewport_width")
var viewport_height = ProjectSettings.get("display/window/size/viewport_height")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):	
		zoom += Vector2(zoom_distance, zoom_distance)
	if event.is_action_pressed("zoom_out"):
		zoom -= Vector2(zoom_distance, zoom_distance)

	# 줌인과 줌아웃의 최대와 최소 제한
	# 줌이 0보다 작아지면 줌인이 되는 현상이 발생.
	zoom.x = clamp(zoom.x, zoom_min, zoom_max)
	zoom.y = clamp(zoom.y, zoom_min, zoom_max)
	

func _process(delta: float) -> void:
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			position += inputs[dir] * cam_speed * delta

	# 카메라의 중심을 구한다.
	var half_width = viewport_width / 2
	var half_height = viewport_height / 2

	# 타일맵의 크기를 구한다.
	var tile_map_size = num_tiles * cell_size

	# 카메라 위치가 화면 밖으로 나가지 않도록 한다.
	position.x = clamp(position.x, half_width - cell_size.x, tile_map_size.x - half_width + cell_size.x)
	position.y = clamp(position.y, half_height - cell_size.y, tile_map_size.y - half_height + cell_size.y)