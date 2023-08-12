extends Node2D

# Variables important for balancing
var projectile1_count
var projectile2_count
var circle_count

var projectile1_scene = preload("res://scenes/projectiles/projectile1.tscn")
var projectile2_scene = preload("res://scenes/projectiles/projectile2.tscn")
var projectile_count
var even = true 

func _ready():
    set_difficulty()
    position = GlobalVariables.evil_neuro.position 
    
    for c in range(circle_count):
        # alternates projectiles 
        var projectile_scene 
        if c % 2 == 0: 
            projectile_scene = projectile1_scene 
            projectile_count = projectile1_count 
        else:
            projectile_scene = projectile2_scene
            projectile_count = projectile2_count 
        
        for i in range(projectile_count): 

            var projectile = projectile_scene.instantiate() 
            var angle = 2 * PI / projectile_count * i
            projectile.direction = Vector2.RIGHT.rotated(angle)
            add_child(projectile)

        await get_tree().create_timer(0.2).timeout

func set_difficulty():
    if GlobalVariables.difficulty_level == 0: 
        circle_count = 2
        projectile1_count = 10
        projectile2_count = 20 
    if GlobalVariables.difficulty_level == 1: 
        circle_count = 2
        projectile1_count = 20
        projectile2_count = 30 
    if GlobalVariables.difficulty_level == 2:
        circle_count = 3
        projectile1_count = 25 
        projectile2_count = 40
    if GlobalVariables.difficulty_level == 3: 
        circle_count = 3
        projectile1_count = 30
        projectile2_count = 50 
