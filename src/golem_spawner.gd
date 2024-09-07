extends Node

@export var golem_scene: PackedScene
@export var golem_count: int = 10

func _ready() -> void:
  for i: int in range(0, golem_count):
    var golem: Node2D = golem_scene.instantiate()
    golem.position = Vector2(i, 0);
    add_sibling.call_deferred(golem)
