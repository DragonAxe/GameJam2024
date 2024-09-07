extends RigidBody2D

@export_category("Internal Nodes")
@export var integrate_forces_modules: Array[Node]

func _input(event: InputEvent) -> void:
  if get_tree().paused or not (event is InputEventKey):
    return

  if event.is_action_pressed("player_grab_release"):
    # Check that obelisk is very close to the player in the direction that they're facing.
    pass

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
  for module: Node in integrate_forces_modules:
    assert(module.has_method("integrate_forces"))
    module.call("integrate_forces", state)

# func get_obelisks_from_scene -> Array[Obelisk]:
