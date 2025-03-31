extends PointLight2D

class_name Point_Light

const LightTexture = preload("res://Asset/Art/Light.png")

var lightImage : Image = LightTexture.get_image()
var light_offset : Vector2i
var imargin : int = 40

func light_image_init(l_range : int) -> void:
	# 시야 범위에 따른 시야를 구현하기 위해
	# 시야 이미지를 리사이즈한다.
	# 실제 gridsize = 128
	# imargin = 40
	# 시야 이미지 그리드 한 칸은 168
    var light_range = (GameManager.tml.cell_size.x + imargin) * l_range
    lightImage.resize(light_range, light_range)

    texture = LightTexture

    @warning_ignore("integer_division")
    light_offset = Vector2i(lightImage.get_width()/2, lightImage.get_height()/2)

    blend_mode = BLEND_MODE_ADD