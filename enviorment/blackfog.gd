extends Sprite2D

class_name BlackFog

var tile_map_layer : TileMapLayer

var fog = null

# 전장의 안개
var fogImage : Image = null
var fogTexture : ImageTexture = null

var grid_size_x : int
var grid_size_y : int
var num_tile_x  : int
var num_tile_y  : int

func create_fogImage() -> void:
    fog = self
    tile_map_layer = GameManager.tml
    grid_size_x = tile_map_layer.cell_size.x
    grid_size_y = tile_map_layer.cell_size.y
    num_tile_x = tile_map_layer.num_tiles.x
    num_tile_y = tile_map_layer.num_tiles.y
    # var fog_image_width = display_width
    # var fog_image_height = display_height

    # scale에 그리드 사이즈를 곱하면 그리드 단위로 변환된다.
    #fog.scale *= grid_size

    fogImage = Image.create(grid_size_x * num_tile_x, grid_size_y * num_tile_y, false, Image.FORMAT_RGBA8)
    fogImage.fill(Color.BLACK)

    # z-index 화면 상에 표시되는 이미지의 순서를 결정한다
    # 클수록 위에 표시된다
    z_index = 3

func update_fog(new_grid_position: Vector2i, image : Image, image_offset : Vector2i) -> void:
    @warning_ignore("integer_division")
    var light_rect = Rect2i(Vector2i.ZERO, 
                    Vector2i(image.get_width(), image.get_height()))
	# blend_rect는 이미지를 복사하고, 블렌딩 모드를 사용하여 이미지를 병합한다.
	# 이 경우, 빛 이미지를 플레이어의 위치에 맞춰서 병합한다.
	# 이때, light_offset을 빼는 이유는 이미지의 중심(플레이어의 위치)을 기준으로 병합하기 때문이다.
    fogImage.blend_rect(image, light_rect, new_grid_position - image_offset)
    update_fog_image_texture()

func update_fog_image_texture():
    fogTexture = ImageTexture.create_from_image(fogImage)
    fog.texture = fogTexture