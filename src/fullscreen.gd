extends Node


#func _input(event: InputEvent) -> void:
  #if event.is_action_pressed("fullscreen"):
    #if get_viewport().get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN:
      #get_viewport().get_window().mode = Window.MODE_WINDOWED
    #else:
      #get_viewport().get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
      


func on_toggled(toggled_on: bool) -> void:
  if toggled_on:
    get_viewport().get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
  else:
    get_viewport().get_window().mode = Window.MODE_WINDOWED
