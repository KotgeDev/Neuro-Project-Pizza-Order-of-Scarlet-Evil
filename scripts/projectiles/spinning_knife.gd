extends Node2D

var direction = Vector2(0, -1)
@export var speed = 75

func _ready():
    $SpinningAnimation.play("spinning_knife")

func _physics_process(delta):
    position += direction * speed * delta 

func _self_destruct(): 
    queue_free() 
