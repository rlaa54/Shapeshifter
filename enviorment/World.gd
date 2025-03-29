extends Node2D

class_name World

# 전장의 안개의 인스턴스를 생성
@onready var blackfog = preload("res://enviorment/fog.tscn").instantiate()
@onready var grayfog = blackfog.duplicate()

const LightTexture = preload("res://Asset/Art/Light.png")

var display_width = ProjectSettings.get("display/window/size/viewport_width")
var display_height = ProjectSettings.get("display/window/size/viewport_height")

var lightImage : Image = LightTexture.get_image()
var light_offset : Vector2i
var tml : TileMapLayer
var imargin : int = 40

func _ready() -> void:
	tml = GameManager.tml
	light_image_init()
	blackfog.create_fogImage(Color.BLACK, 3)
	grayfog.create_fogImage(Color.DARK_BLUE, 1)
	#grayfog.blend_mode = CanvasItemMaterial.BLEND_MODE_MIX
	#add_child(blackfog)
	add_child(grayfog)

func _process(_delta: float) -> void:
	# 캐릭터의 위치를 중심으로 전장의 안개를 업데이트해 시야를 밝힌다
	# 프레임마다 호출된다.
	blackfog.fog_blend_light(GameManager.pc.position, lightImage, light_offset, false)
	blackfog.update_fog_texture()
	grayfog.fog_blend_light(GameManager.pc.position, lightImage, light_offset, true)
	grayfog.update_fog_texture()

func light_image_init() -> void:
	# 시야 범위에 따른 시야를 구현하기 위해
	# 시야 이미지를 리사이즈한다.
	# 실제 gridsize = 128
	# imargin = 40
	# 시야 이미지 그리드 한 칸은 168
	var light_one_grid = (tml.cell_size.x + imargin) * GameManager.pc.stats.visible_range
	lightImage.resize(light_one_grid, light_one_grid)

	@warning_ignore("integer_division")
	light_offset = Vector2i(lightImage.get_width()/2, lightImage.get_height()/2)
