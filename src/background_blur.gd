extends ColorRect

@export_category("Scene Internal Nodes")
@export var animation_player: AnimationPlayer

var was_paused: bool = false

func _ready() -> void:
  self.visible = false


func _process(_delta: float) -> void:
  if get_tree().paused and not was_paused:
    # Pause
    self.visible = true
    animation_player.play("blur")
    was_paused = true
  if not get_tree().paused and was_paused:
    # Unpause
    animation_player.play_backwards("blur")
    was_paused = false


func _on_animation_finished(anim_name: StringName) -> void:
  if not get_tree().paused and anim_name == "blur":
    self.visible = false
