extends Area2D

signal finished

@onready var collision_shape_2d = $CollisionShape2D
@onready var nuke_sprite = $NukeSprite
@onready var neuro = GlobalVariables.neuro 
@onready var world = GlobalVariables.world

var rng = RandomNumberGenerator.new() 
var radiation_scene = preload("res://scenes/projectiles/radiation.tscn")
var expand_speed = 50 
var signal_fired = false 
var used_coordinates = [[0,0]]

func _process(delta):
    if scale.x < 53: 
        expand(delta)
    elif scale.x >= 53 and not signal_fired:
        signal_fired = true 
        finished.emit() 
        add_radiation() 
        remove_nuke() 

func expand(delta):
    scale.x += expand_speed * delta
    scale.y += expand_speed * delta 

func remove_nuke():
    $CollisionShape2D.disabled = true 
    var tween = get_tree().create_tween() 
    tween.tween_property(nuke_sprite, "modulate", Color(0,0,0,0), 0.5)
    tween.finished.connect(_on_tween_finished)

func add_radiation(): 
    for i in range(5): 
        var radiation = radiation_scene.instantiate()
        world.add_child(radiation)
        var x_min = neuro.global_position.x - 60 
        var x_max = neuro.global_position.x + 60
        var y_min = neuro.global_position.y - 60
        var y_max = neuro.global_position.y + 60
        var random_x
        var random_y 
        
        var retry = true 
        while retry: 
            retry = false
            random_x = rng.randi_range(0, 3) * 20 + x_min
            random_y = rng.randi_range(0, 3) * 20 + y_min
            for c in used_coordinates: 
                if c[0] == random_x and c[1] == random_y:
                    retry = true 
                    
        radiation.global_position = Vector2(random_x, random_y)
        used_coordinates.append([random_x, random_y])

func _on_tween_finished():
    queue_free()

