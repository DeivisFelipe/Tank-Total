extends Area2D
	
var dir = null : set = set_dir, get = get_dir
	
var velocidade = 1000

func _ready():
	pass

func _process(delta):
	translate(dir * velocidade * delta)


func _on_notifier_screen_exited():
	queue_free()
	
func set_dir(val):
	# rotaciona a imagem
	dir = val
	rotation = dir.angle()

func get_dir():
	return dir
