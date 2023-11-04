@tool
extends CharacterBody2D

const velocidade = 300.0
var preBala = preload("res://cenas/bala.tscn")

var corpos = [
	"res://sprites/tankBody_bigRed.png",
	"res://sprites/tankBody_blue.png",
	"res://sprites/tankBody_red.png",
	"res://sprites/tankBody_sand.png",
	"res://sprites/tankBody_dark.png"
]

@export_range(0, 4) var corpo: int  = 4 : set = set_corpo, get = get_corpo

func _ready():
	pass
	
func _draw():
	$Sprite.texture = load(corpos[corpo])

func _physics_process(delta):
	if Engine.is_editor_hint():
		return
		
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up", "ui_down")
	
	if directionX:
		velocity.x = directionX * velocidade
	else:
		velocity.x = move_toward(velocity.x, 0, velocidade)
		
	if directionY:
		velocity.y = directionY * velocidade
	else:
		velocity.y = move_toward(velocity.y, 0, velocidade)
		
	# Tiro
	var atirou = Input.is_action_just_pressed("ui_shoot")
	if atirou:
		var numeroBalas = get_tree().get_nodes_in_group("balas" + str(self)).size()
		if numeroBalas < 3:
			var bala = preBala.instantiate()
			bala.add_to_group("balas" + str(self))
			bala.global_position = $cano/disparador.global_position
			bala.dir = Vector2(cos(rotation), sin(rotation))
			$cano/AnimationPlayer.play("fire")
			get_parent().add_child(bala)
			
			# Tiro som
			$SomTiro.play()
			
	look_at(get_global_mouse_position())

	move_and_slide()

func set_corpo(val):
	corpo = val
	queue_redraw()
	
func get_corpo():
	return corpo
