class_name Obelisk extends Node2D

@export var particle_count : int
@export var pulse_distance : float
@export var pulse_thickness : float
@export var power_type : PowerType

enum PowerType { FAST, SLOW, REPULSE, SENSORY, SPAWN }

var particle_scene : PackedScene
var particle_texture_size : Vector2
var particles : Array[Node2D]
var pulsed : bool = false
var pulse_active : bool = false
var current_radius : float
var power_duration : float

var golems : Array[Golem]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  current_radius = 0

  particle_scene = preload("res://scenes/particle.tscn")
  for i : int in range(particle_count):
    var particle : Node2D = particle_scene.instantiate()
    add_child(particle)
    particles.append(particle)
    particle.visible = false

  particle_texture_size = (particles[0].get_children()[0] as Sprite2D).texture.get_size()

  golems.assign(get_tree().get_nodes_in_group("golem"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  for golem : Golem in golems:
    var distance_to_golem : float = golem.position.distance_to(position)
    if distance_to_golem < current_radius + pulse_thickness / 2 and distance_to_golem > current_radius - pulse_thickness / 2:
      golem.power_up(power_type, power_duration)

func update_pulse_wave(frac: float) -> void:
  for i : int in range(len(particles)):
    var particle : Node2D = particles[i]
    # r is the distance from the center
    current_radius = pulse_distance * frac
    particle.position = Vector2(current_radius * cos(PI * 2 * i / particle_count), current_radius * sin(PI * 2 * i / particle_count))
    # s is the length of the side of a regular polygon
    var s : float = 2.15 * current_radius * sin(PI / particle_count)
    particle.scale = Vector2(s / particle_texture_size.x, pulse_thickness / particle_texture_size.y)
    particle.rotation = PI * 2 * i / particle_count + PI / 2

func activate_pulse(_pulse_active : bool) -> void:
  pulse_active = _pulse_active

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

  current_radius = 0
  pulsed = false
