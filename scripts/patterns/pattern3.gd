extends Node2D

@onready var neuro = GlobalVariables.neuro
@onready var right_marker = $RightMarker
@onready var down_marker = $DownMarker

var knife_right_scene = preload("res://scenes/projectiles/knife_right.tscn")
var knife_down_scene = preload("res://scenes/projectiles/knife_down.tscn")

func _ready():
    var neuro_x_position = neuro.global_position.x 
    var neuro_y_position = neuro.global_position.y
    
    right_marker.visible = true 
    down_marker.visible = true
    right_marker.global_position = Vector2(25, neuro_y_position)
    down_marker.global_position = Vector2(neuro_x_position, 25)
    await get_tree().create_timer(1).timeout
    
    var knife_right = knife_right_scene.instantiate()
    var knife_down = knife_down_scene.instantiate()
    add_child(knife_right)
    add_child(knife_down)
    knife_right.global_position = Vector2(25, neuro_y_position)
    knife_down.global_position = Vector2(neuro_x_position, 25)
    await get_tree().create_timer(0.8).timeout 
    
    right_marker.visible = false 
    down_marker.visible = false
