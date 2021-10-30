class_name VitalEntity
extends KinematicEntity

export(int) var _maximumHealth = 100
export(int) var _currentHealth = 100

# networking
puppet var puppet_current_health = _currentHealth

var _isInHitFrames = false

func _hurt(agent: Node, damage: int, damageType: String) -> void:
	pass

func _impulse(agent: Node, impulse: Vector3):
	pass

func _physics_process(delta):
	if(get_tree().is_network_server()):
		rset_unreliable("puppet_current_health", _currentHealth)
	else:
		_currentHealth = puppet_current_health
