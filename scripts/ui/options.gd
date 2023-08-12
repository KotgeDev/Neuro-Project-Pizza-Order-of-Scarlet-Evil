extends Control

func _ready():
    $VBoxContainer/OptionButton.selected = GlobalVariables.difficulty_level

func _on_back_pressed():
    get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")

func _on_option_button_item_selected(index):
    GlobalVariables.difficulty_level = index 
