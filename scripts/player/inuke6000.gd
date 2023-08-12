extends Area2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var nuke_sprite = $NukeSprite
@onready var neuro = GlobalVariables.neuro 
@onready var world = GlobalVariables.world

var rng = RandomNumberGenerator.new() 
var radiation_scene = preload("res://scenes/projectiles/radiation.tscn")
var expand_speed = 50 
var began_decaying = false 

func _process(delta):
    if scale.x < 53: 
        expand(delta)
    elif scale.x >= 53 and not began_decaying:
        began_decaying = true 
        begin_decay() 
        add_radiation() 

func expand(delta):
    scale.x += expand_speed * delta
    scale.y += expand_speed * delta 

func begin_decay():
    var tween = get_tree().create_tween() 
    tween.tween_property(nuke_sprite, "modulate", Color(0,0,0,0), 2)
    tween.finished.connect(_on_tween_finished)

func add_radiation(): 
    for i in range(5): 
        var radiation = radiation_scene.instantiate()
        world.add_child(radiation)
        radiation.global_position = Vector2(rng.randi_range(25, 350), rng.randi_range(25, 425))

func _on_tween_finished():
    queue_free()

