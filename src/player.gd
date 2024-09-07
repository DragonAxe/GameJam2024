extends RigidBody2D

@export_category("Internal Nodes")
@export var integrate_forces_modules: Array[Node]


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
  for module: Node in integrate_forces_modules:
    assert(module.has_method("integrate_forces"))
    module.call("integrate_forces", state)
