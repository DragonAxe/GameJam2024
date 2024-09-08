class_name GolemTimer extends Timer

@export var movement : Node
@export var power_type : Obelisk.PowerType

func power_up(power_duration : float) -> void:
  start(power_duration)
  assert(movement.has_method("power_up"))
  movement.call("power_up", power_type)

func _on_timeout() -> void:
  assert(movement.has_method("power_down"))
  movement.call("power_down", power_type)
