extends Node

const TextInput = preload("res://scenes/text_input.tscn")

@onready var cursor := %Cursor as Cursor
@onready var items := %Items as Node
@onready var color_picker_button := $UI/ColorPickerButton as ColorPickerButton
@onready var change_width_speed = 3
var active_item = null
var undo_stack := []
var line_width := 10.0
var color := Color.BLACK

func _ready():
  cursor.radius = line_width / 2.0
  on_color_changed(color)
  color_picker_button.color_changed.connect(on_color_changed)

func _unhandled_input(event):
  if event is InputEventMouseButton:
    var mouse := event as InputEventMouseButton
    match mouse.button_index:
      MOUSE_BUTTON_LEFT:
        if mouse.pressed:
          on_LMB_pressed()
        else:
          on_LMB_released()
      MOUSE_BUTTON_MASK_RIGHT:
        if mouse.pressed: on_RMB_pressed()
      MOUSE_BUTTON_WHEEL_DOWN:
        if mouse.pressed: change_line_width(+change_width_speed)
      MOUSE_BUTTON_WHEEL_UP:
        if mouse.pressed: change_line_width(-change_width_speed)
  if event is InputEventKey:
    var key := event as InputEventKey
    if (key.ctrl_pressed or key.meta_pressed) and key.pressed:
      match key.keycode:
        KEY_Z:
          on_CMD_Z_pressed()
        KEY_Y:
          on_CMD_Y_pressed()

func change_line_width(diff: int):
  line_width += diff
  line_width = clamp(line_width, 1, 100)
  cursor.radius = line_width / 2
        
func on_LMB_pressed():
  get_viewport().gui_release_focus()
  var line := Trail2D.make(cursor, false, line_width, color)
  items.add_child(line)
  active_item = line
  undo_stack = [] # clear undo

func on_LMB_released():
  if active_item is Trail2D:
    if active_item.points.size() <= 1:
      items.remove_child(items.get_children().back())
    active_item.target = null
    active_item = null
    
func on_RMB_pressed():
  var text_input := TextInput.instantiate() as LineEdit
  text_input.add_theme_font_size_override("font_size", max(24, line_width))
  text_input.global_position = cursor.global_position + Vector2.UP * text_input.size.y / 2
  items.add_child(text_input)
  active_item = text_input
  undo_stack = [] # clear undo
    
func on_CMD_Z_pressed():
  var tail = items.get_children().back()
  if tail != null:
    items.remove_child(tail)
    undo_stack.push_back(tail)
  
func on_CMD_Y_pressed():
  var top = undo_stack.pop_back()
  if top != null:
    items.add_child(top)    

func on_color_changed(_color: Color):
  self.color = _color
  cursor.cursor_color = _color
