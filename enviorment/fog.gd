extends Sprite2D

const LightTexture = preload("res://Asset/Art/Light.png")

var tile_map_layer : TileMapLayer
var grid_size : int
var fog

var display_width = ProjectSettings.get("display/window/size/viewport_width")
var display_height = ProjectSettings.get("display/window/size/viewport_height")

var fogImage = Image.new()
var fogTexture = ImageTexture.new()
var lightImage : Image = LightTexture.get_image()
var light_offset : Vector2i

func _ready() -> void:
    fog = self
    tile_map_layer = GameManager.tml
    grid_size = tile_map_layer.cell_size.x
    var fog_image_width = display_width
    var fog_image_height = display_height
    fogImage = Image.create(fog_image_width, fog_image_height, false, Image.FORMAT_RGBA8)
    fogImage.fill(Color.BLACK)
    fog.scale *= grid_size

	# 시야 범위에 따른 시야를 구현하기 위해
	# 빛 이미지를 리사이즈한다.
    lightImage.resize(4, 4)

    @warning_ignore("integer_division")
    light_offset = Vector2i(lightImage.get_width()/2, lightImage.get_height()/2)

    # z-index 화면 상에 표시되는 이미지의 순서를 결정한다
    # 클수록 위에 표시된다
    z_index = 1

func _process(_delta: float) -> void:
	# 캐릭터의 위치를 중심으로 전장의 안개를 업데이트해 시야를 밝힌다
	# 프레임마다 호출된다.
    update_fog(GameManager.pc.position)

func update_fog(new_grid_position: Vector2i) -> void:
    @warning_ignore("integer_division")
    var light_rect = Rect2i(Vector2i.ZERO, 
                    Vector2i(lightImage.get_width(), lightImage.get_height()))
	# blend_rect는 이미지를 복사하고, 블렌딩 모드를 사용하여 이미지를 병합한다.
	# 이 경우, 빛 이미지를 플레이어의 위치에 맞춰서 병합한다.
	# 이때, light_offset을 빼는 이유는 이미지의 중심을 기준으로 병합하기 때문이다.					
	# grid_size로 나누는 이유는 좌표를 그리드 좌표로 변환하기 위함이다.
    fogImage.blend_rect(lightImage, light_rect, (new_grid_position/grid_size) - light_offset)
    update_fog_image_texture()

func update_fog_image_texture():
    fogTexture = ImageTexture.create_from_image(fogImage)
    fog.texture = fogTexture