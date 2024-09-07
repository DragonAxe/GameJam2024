extends RigidBody2D

@export_category("Internal nodes")
@export var navigation_agent: NavigationAgent2D


func _ready() -> void:
  set_movement_target.call_deferred(global_position)
  var _ignore: int = navigation_agent.target_reached.connect(target_reached)


func _process(delta: float) -> void:
  pass


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
  pass


func set_movement_target(movement_target: Vector2) -> void:
  await get_tree().physics_frame
  navigation_agent.target_position = movement_target


func target_reached() -> void:
  pass
