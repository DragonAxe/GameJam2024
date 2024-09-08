class_name GolemTimer extends Timer

@export var movement : Node
@export var power_type : Obelisk.PowerType

var empowered : bool = false

func power_up(power_duration : float) -> void:
  if empowered:
    return
  start(power_duration)
  assert(movement.has_method("power_up"))
  movement.call("power_up", power_type)
  print(power_duration)
  empowered = true

func _on_timeout() -> void:
  assert(movement.has_method("power_down"))
  movement.call("power_down", power_type)
  empowered = false
