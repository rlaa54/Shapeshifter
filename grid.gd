extends TileMapLayer

var tile_size = 64

# Draw the grid
func _draw() -> void:
	var width = get_viewport_rect().size.x
	var height = get_viewport_rect().size.y
	
	for x in range(0, width, tile_size):
		draw_line(Vector2(x, 0), Vector2(x, height), Color(0, 0, 0))
	
	for y in range(0, height, tile_size):
		draw_line(Vector2(0, y), Vector2(width, y), Color(0, 0, 0))