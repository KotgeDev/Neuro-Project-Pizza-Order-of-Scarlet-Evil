extends Control

func _on_start_button_pressed():
    get_tree().change_scene_to_file("res://scenes/world/world.tscn")

func _on_option_button_pressed():
    get_tree().change_scene_to_file("res://scenes/ui/options.tscn")

func _on_quit_button_pressed():
    get_tree().quit() 
