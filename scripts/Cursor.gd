extends Node2D
class_name Cursor

var radius := 10.0:
  set(_r):
    radius = _r
    queue_redraw()
var cursor_color := Color.DEEP_SKY_BLUE:
  set(_c):
    cursor_color = _c
    queue_redraw()
var circle_width := 3 # px
var circle_resolution = 60

func _draw():
  draw_arc(Vector2.ZERO,\
    radius,\
    0, 2 * PI,\
    circle_resolution, cursor_color, circle_width)

func _process(delta):
  global_position = get_global_mouse_position()
