extends Sprite2D

class_name Fog

var tile_map_layer : TileMapLayer

var fog = null

# 전장의 안개
# 이미지
var fogImage : Image = null
# 이미지 텍스처
var fogTexture : ImageTexture = null
# 깨끗한 이미지 항상 갱신되지 않은 순수한 이미지여야 함
var cleanImage : Image = null

var grid_size_x : int
var grid_size_y : int
var num_tile_x  : int
var num_tile_y  : int

func create_fogImage(color : Color) -> void:
    fog = self
    tile_map_layer = GameManager.tml
    grid_size_x = tile_map_layer.cell_size.x
    grid_size_y = tile_map_layer.cell_size.y
    num_tile_x = tile_map_layer.num_tiles.x
    num_tile_y = tile_map_layer.num_tiles.y
    
    @warning_ignore("integer_division")
    position = Vector2((grid_size_x * num_tile_x) / 2, (grid_size_y * num_tile_y) / 2)
    # var fog_image_width = display_width
    # var fog_image_height = display_height

    # scale에 그리드 사이즈를 곱하면 그리드 단위로 변환된다.
    #fog.scale *= grid_size

    fogImage = Image.create(grid_size_x * num_tile_x, grid_size_y * num_tile_y, false, Image.FORMAT_RGBA8)
    fogImage.fill(color)

    # z-index 화면 상에 표시되는 이미지의 순서를 결정한다
    # 클수록 위에 표시된다

    # fogImage의 복사본을 생성하여 깨끗한 이미지를 만든다
    # cleanImage는 갱신되지 않아야 함
    cleanImage = fogImage.duplicate()
    
    update_fog_texture()

# 이미지를 블렌드 함
func fog_blend_light(new_grid_position: Vector2i, image : Image, image_offset : Vector2i, is_gray : bool) -> void:
    @warning_ignore("integer_division")
    var light_rect = Rect2i(Vector2i.ZERO, 
                    Vector2i(image.get_width(), image.get_height()))
	
    # 회색안개라면 깨끗한 이미지를 블렌드하기 위해 복사본을 만든다
    if is_gray:
        fogImage = cleanImage.duplicate()
    
    # blend_rect는 이미지를 복사하고, 블렌딩 모드를 사용하여 이미지를 병합한다.
	# 이 경우, 빛 이미지를 플레이어의 위치에 맞춰서 병합한다.
	# 이때, light_offset을 빼는 이유는 이미지의 중심(플레이어의 위치)을 기준으로 병합하기 때문이다.
    fogImage.blend_rect(image, light_rect, new_grid_position - image_offset)
    update_fog_texture()

# 텍스처를 업데이트 함
func update_fog_texture():
    fogTexture = ImageTexture.create_from_image(fogImage)
    self.texture = fogTexture