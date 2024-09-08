class_name BackgroundBlur extends ColorRect

@export var blur_modifier: float = 2

@export_category("Scene Internal Nodes")
@export var animation_player: AnimationPlayer

var was_visible: bool = false
var currently_visible: bool = false

func _ready() -> void:
  self.visible = false
  var shader_material: ShaderMaterial = material
  shader_material.set_shader_parameter("blur_multiplier", blur_modifier)


func _process(_delta: float) -> void:
  if currently_visible and not was_visible:
    # Pause
    self.visible = true
    animation_player.play("blur")
    was_visible = true
  if not currently_visible and was_visible:
    # Unpause
    animation_player.play_backwards("blur")
    was_visible = false


func _on_animation_finished(anim_name: StringName) -> void:
  if not currently_visible and anim_name == "blur":
    self.visible = false


func update_visibility(_is_visible: bool) -> void:
  currently_visible = _is_visible
