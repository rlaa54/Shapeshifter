extends Node2D

const LightTexture = preload("res://Asset/Art/Light.png")
const GRID_SIZE = 128

@onready var fog = $Fog

var display_width = ProjectSettings.get("display/window/size/viewport_width")
var display_height = ProjectSettings.get("display/window/size/viewport_height")

var fogImage = Image.new()
var fogTexture = ImageTexture.new()
var lightImage = LightTexture.get_image()
var light_offset = Vector2(LightTexture.get_width()/2, LightTexture.get_height()/2)

func _ready() -> void:
	var fog_image_width = display_width / GRID_SIZE
	var fog_image_height = display_height / GRID_SIZE
	fogImage = Image.create(fog_image_width, fog_image_height, false, Image.FORMAT_RGBAH)
	fogImage.fill(Color.BLACK)
	fog.scale *= GRID_SIZE

func update_fog(new_grid_position):
	var light_rect = Rect2(Vector2.ZERO, 
					Vector2(lightImage.get_width(), lightImage.get_height()))
	fogImage.blend_rect(lightImage, light_rect, new_grid_position - light_offset)

	update_fog_image_texture()

func update_fog_image_texture():
	fogTexture = ImageTexture.create_from_image(fogImage)
	fog.texture = fogTexture

func _input(_event: InputEvent) -> void:
	update_fog(get_local_mouse_position()/GRID_SIZE)