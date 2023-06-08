extends Node2D
class_name Cursor

var radius := 10.0:
  set(_radius):
    radius = _radius
    queue_redraw()
var cursor_color := Color.BLACK:
  set(_color):
    cursor_color = _color
    queue_redraw()
    
@export var circle_width := 10 # px

var circle_resolution = 36

func _draw():
#  draw_circle(global_position, radius, Color.DARK_GRAY)
  draw_arc(Vector2.ZERO,\
    radius,\
    0, 2 * PI,\
    circle_resolution, cursor_color, circle_width)

func _process(delta):
  global_position = get_global_mouse_position()
