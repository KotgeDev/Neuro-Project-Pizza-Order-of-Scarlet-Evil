extends Node2D

# Variables important for balancing
var circle_count
var projectile_count

@onready var evil_neuro = GlobalVariables.evil_neuro

var projectile_scene = preload("res://scenes/projectiles/spinning_knife.tscn")
var even = true 

func _ready():
    set_difficulty() 
    
    position = evil_neuro.position 
    
    for c in range(circle_count):
        for i in range(projectile_count): 
            var projectile = projectile_scene.instantiate() 
            var angle = 2 * PI / projectile_count * i
            projectile.direction = Vector2.RIGHT.rotated(angle)
            add_child(projectile)

        await get_tree().create_timer(0.2).timeout

func set_difficulty():
    if GlobalVariables.difficulty_level == 0: 
        circle_count = 1
        projectile_count = 20 
    if GlobalVariables.difficulty_level == 1: 
        circle_count = 1
        projectile_count = 30 
    if GlobalVariables.difficulty_level == 2:
        circle_count = 1
        projectile_count = 40 
    if GlobalVariables.difficulty_level == 3: 
        circle_count = 1
        projectile_count = 50 

