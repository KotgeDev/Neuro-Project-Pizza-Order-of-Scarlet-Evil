extends Control

func _ready():
    %OptionButton.selected = GlobalVariables.difficulty_level
    $VBoxContainer2/HSlider.value = GlobalVariables.music_volume

func _on_back_pressed():
    get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")

func _on_option_button_item_selected(index):
    GlobalVariables.difficulty_level = index 

func _on_h_slider_value_changed(value):
    GlobalVariables.music_volume = value
