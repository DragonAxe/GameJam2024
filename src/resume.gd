extends Button

signal resume


func _on_pressed() -> void:
  resume.emit()
