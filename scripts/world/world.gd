extends Node2D

var phase1_scene = preload("res://scenes/phases/phase1.tscn") #TODO: CHANGE BACK AFTER TESTING 
var phase2_scene = preload("res://scenes/phases/phase2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    GlobalVariables.evil_neuro = $EvilNeuro
    GlobalVariables.neuro = $player
    GlobalVariables.world = self 
    
    var phase1 = phase1_scene.instantiate()
    phase1.complete.connect(_on_phase1_complete)
    add_child(phase1) 

func _on_phase1_complete():
    var phase2 = phase2_scene.instantiate() 
    phase2.complete.connect(_on_phase2_complete)
    add_child(phase2)
    
func _on_phase2_complete():
    $HUD.show_game_won() 

func _on_player_destroyed():
    $HUD.show_game_over()

func _return_to_menu():
    get_tree().change_scene_to_file("res://scenes/ui/menu.tscn")

func _new_game():
    get_tree().change_scene_to_file("res://scenes/world/world.tscn")
