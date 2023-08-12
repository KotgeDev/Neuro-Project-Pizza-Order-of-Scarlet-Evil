extends CanvasLayer

signal start_game 
signal return_to_menu 

@onready var sprite1 = $Sprite2D
@onready var sprite2 = $Sprite2D2
@onready var sprite3 = $Sprite2D3
@onready var retry_button = $VBoxContainer/RetryButton
@onready var menu_button = $VBoxContainer/MenuButton


var menu_shown = false  
var menu_allowed = true 

func _ready():
    retry_button.hide()
    menu_button.hide()

func _physics_process(delta):
    if Input.is_action_just_pressed("menu") and menu_allowed:
        if menu_button.is_visible_in_tree(): 
            hide_menu() 
        else:
            show_menu()
    
    # Maybe rewrite this using signals, idk. 
    if GlobalVariables.neuro.health == 3: 
        sprite1.show()
        sprite2.show()
        sprite3.show() 
    if GlobalVariables.neuro.health == 2:
        sprite3.hide()
    if GlobalVariables.neuro.health == 1: 
        sprite2.hide()
        sprite3.hide()
    if GlobalVariables.neuro.health == 0: 
        sprite1.hide()
        sprite2.hide()
        sprite3.hide() 

func show_game_over(): 
    sprite1.hide()
    sprite2.hide()
    sprite3.hide() 
    
    menu_allowed = false 
    get_tree().paused = true 
    $Message.text = "Game Over"
    $Message.show()
    await get_tree().create_timer(2).timeout
    $Message.hide()
    retry_button.show()
    menu_button.show()

func show_game_won(): 
    menu_allowed = false 
    get_tree().paused = true 
    $Message.text = "You Win!"
    $Message.show()
    await get_tree().create_timer(2).timeout
    $Message.hide()
    retry_button.show()
    menu_button.show()

func show_menu(): 
    get_tree().paused = true 
    retry_button.show()
    menu_button.show()

func hide_menu(): 
    retry_button.hide()
    menu_button.hide()
    get_tree().paused = false 

func _on_retry_button_pressed():
    retry_button.hide()
    menu_button.hide()
    get_tree().paused = false 
    start_game.emit() 

func _on_menu_button_pressed():
    retry_button.hide()
    menu_button.hide()
    get_tree().paused = false
    return_to_menu.emit()
