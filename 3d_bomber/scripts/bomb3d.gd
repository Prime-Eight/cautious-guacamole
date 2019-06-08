extends Spatial

# Declare member variables here. Examples:
var in_area = []
var from_player

var animplayer : AnimationPlayer = null
var animSpeed : float = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	animplayer = get_node("AnimationPlayer")
	animplayer.play("flash") 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta): 
	
	animSpeed += 0.6 * delta
	if animSpeed >= 5:
		print("boom")
		explode()
		queue_free()
	animplayer.set_speed_scale(animSpeed)
	
func _on_Area_body_entered(body):
	if (not body in in_area):
		in_area.append(body)
		#print("bomb gonan get you " + str( in_area.size() ) )

func _on_Area_body_exited(body):
#	if body in in_area:
#		print("Safe from bomb")
	in_area.erase(body)
	
	
func done():
	queue_free()
#
# Called from the animation
func explode():
	if (not is_network_master()):
		# But will call explosion only on master
		return
	for p in in_area:
		if (p.has_method("exploded")):
			p.rpc("exploded", from_player) # Exploded has a master keyword, so it will only be received by the master




