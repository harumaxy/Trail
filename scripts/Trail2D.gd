extends Line2D
class_name Trail2D

const tick_rate = 0.01
@export var min_distance := 3 #px
@export var dissolve := true
@export_range(0.1, 1.0, 0.1) var dissolve_time := .5
@onready var tick_tween = create_tween()


@export var target: Node2D = null:
  set(_target):
    target = _target
    if _target:
      add_point(target.global_position)
    else:
      tick_tween.pause()


func _ready():
  self.top_level = true
  tick_tween.tween_interval(tick_rate)
  tick_tween.tween_callback(tick)
  tick_tween.set_loops()

func tick():
  if target == null:
    return
  var point = target.global_position
  var last_point = points[points.size() - 1] if points.size() > 0 else null
  if last_point != null and \
    point.distance_to(last_point) > min_distance:
    add_point(point)
    # disolve points by time
    if dissolve:
      await get_tree().create_timer(dissolve_time).timeout
      remove_point(0)
      

