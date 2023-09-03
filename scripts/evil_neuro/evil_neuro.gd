extends Node2D

signal take_damage

@onready var cogwheel_animation_player = $CogwheelAnimationPlayer
@onready var evil_neuro_animation_player = $EvilNeuroAnimationPlayer
@onready var sprite_2d = $Sprite2D

func _on_hurtbox_take_damage(damage):
    take_damage.emit(damage)
    
    sprite_2d.modulate = Color("f58122")
    await get_tree().create_timer(0.05).timeout 
    sprite_2d.modulate = Color("ffffff")

func _ready(): 
    cogwheel_animation_player.play("cogwheel_spin") 
    evil_neuro_animation_player.play("idle")

