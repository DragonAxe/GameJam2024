class_name Golem extends RigidBody2D

@export_category("Internal Nodes")
@export var integrate_forces_modules: Array[Node]
@export var power_up_timer_fast: Node
@export var power_up_timer_sensory: Node
@export var power_up_timer_repulse: Node

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
  for module: Node in integrate_forces_modules:
    assert(module.has_method("integrate_forces"))
    module.call("integrate_forces", state)

func power_up(power_type : Obelisk.PowerType, power_duration : float, vector_away : Vector2) -> void:
  if power_type == Obelisk.PowerType.FAST:
    assert(power_up_timer_fast.has_method("power_up"))
    power_up_timer_fast.call("power_up", power_duration, vector_away)
  elif power_type == Obelisk.PowerType.SENSORY:
    assert(power_up_timer_sensory.has_method("power_up"))
    power_up_timer_sensory.call("power_up", power_duration, vector_away)
  elif power_type == Obelisk.PowerType.REPULSE:
    assert(power_up_timer_sensory.has_method("power_up"))
    power_up_timer_repulse.call("power_up", power_duration, vector_away)
