extends Node

@export_category("Sibling nodes")
@export var attack_area: Area2D

@export_category("Internal nodes")
@export var attack_timer: Timer
@export var attack_sound: AudioStreamPlayer

@onready var parent: RigidBody2D = get_parent()


func _physics_process(delta: float) -> void:
  for body: Node2D in attack_area.get_overlapping_bodies():
    if body.is_in_group("player") and attack_timer.is_stopped():
      attack_timer.start()


func on_attack_timer_timeout() -> void:
  for body: Node2D in attack_area.get_overlapping_bodies():
    if body.is_in_group("player"):
      var player: RigidBody2D = body
      var vector_to_player: Vector2 = player.global_position - parent.global_position
      player.apply_central_impulse(vector_to_player.normalized() * 1000)
      attack_sound.play()
