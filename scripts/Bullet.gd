extends RigidBody2D

func _ready():
  $Trail2D.target = self

func _on_visible_on_screen_notifier_2d_screen_exited():
  self.queue_free()
