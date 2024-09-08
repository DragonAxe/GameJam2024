extends Node

@export_category("Sibling Nodes")
@export var health_node: PlayerHealth
@export var golem_scene: PackedScene
@export var camera: Camera2D

@onready var parent: RigidBody2D = get_parent()

var dead: bool = false

func _process(delta: float) -> void:
  if health_node.health <= 0.001 and not dead:
    dead = true
    var death_position: Vector2 = parent.global_position
    parent.remove_child(camera)
    parent.get_parent().add_child(camera)
    camera.global_position = death_position
    var golem: Golem = golem_scene.instantiate()
    parent.get_parent().add_child(golem)
    golem.global_position = death_position
    golem.modulate = Color.LIGHT_GREEN
    parent.get_parent().remove_child(parent)
    parent.queue_free()
    
