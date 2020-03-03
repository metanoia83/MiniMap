extends Spatial

onready var Player = get_parent().get_node("Player")

func _process(delta):
	translation = Player.translation
	translation.y = Player.translation.y - 1.0
	
	

