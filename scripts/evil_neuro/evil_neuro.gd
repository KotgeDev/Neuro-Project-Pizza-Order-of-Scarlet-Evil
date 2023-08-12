extends Node2D

signal take_damage

@onready var cogwheel_animation_player = $CogwheelAnimationPlayer
@onready var evil_neuro_animation_player = $EvilNeuroAnimationPlayer

func _on_hurtbox_take_damage(damage):
    take_damage.emit(damage)

func _ready(): 
    cogwheel_animation_player.play("cogwheel_spin") 
    evil_neuro_animation_player.play("idle")
    
