class_name Obelisk extends Node2D

@export var particle_count : int
@export var pulse_distance : float
@export var pulse_thickness : float

var particle_scene : PackedScene
var particle_texture_size : Vector2
var particles : Array[Node2D]
var pulsed : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  particle_scene = preload("res://scenes/particle.tscn")
  for i : int in range(particle_count):
    var particle : Node2D = particle_scene.instantiate()
    add_child(particle)
    particles.append(particle)

  particle_texture_size = (particles[0].get_children()[0] as Sprite2D).texture.get_size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  pass

func update_pulse_wave(frac: float) -> void:
  for i : int in range(len(particles)):
    var particle : Node2D = particles[i]
    var r : float = pulse_distance * frac
    particle.position = Vector2(r * cos(PI * 2 * i / particle_count), r * sin(PI * 2 * i / particle_count))
    var s : float = 2.15 * r * sin(PI / particle_count)
    particle.scale = Vector2(s / particle_texture_size.x, pulse_thickness / particle_texture_size.y)
    particle.rotation = PI * 2 * i / particle_count + PI / 2

func pulse() -> void:
  if pulsed:
    return
  
  for i : int in range(len(particles)):
    var particle : Node2D = particles[i]
    particle.visible = true

  pulsed = true

func reset() -> void:
  for particle : Node2D in particles:
    particle.visible = false

  pulsed = false
