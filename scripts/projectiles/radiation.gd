extends Node2D

@onready var animation_player = $AnimationPlayer

func _ready():
    $Hitbox/CollisionPolygon2D.disabled = true 
    animation_player.play("radiation")
    await animation_player.animation_finished 
    $Hitbox/CollisionPolygon2D.disabled = false
    
    
