extends Node


func _ready() -> void:
  if get_tree().get_nodes_in_group("disable_escape_to_quit"):
    get_parent().remove_child.call_deferred(self)

func _unhandled_input(event: InputEvent) -> void:
  if event.is_action_pressed("escape_to_quit"):
    get_tree().quit()
