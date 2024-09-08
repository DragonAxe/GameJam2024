extends CanvasLayer

@export_category("Scene Internal Nodes")
@export var dialog: Control
@export var focused_control: Control


func _ready() -> void:
  visible = true
  dialog.visible = false


func _input(event: InputEvent) -> void:
  if get_tree().paused:
    if event.is_action_pressed("ui_cancel") or event.is_action_pressed("pause_unpause"):
      resume()
  else:
    if event.is_action_pressed("pause_unpause"):
      pause()
    


func resume() -> void:
  get_tree().paused = false
  dialog.visible = false


func pause() -> void:
  focused_control.grab_focus()
  get_tree().paused = true
  dialog.visible = true
