extends SpringArm3D

@onready var camera: Camera3D = $Camera3D

func _ready() -> void:

	spring_length = camera.position.z
	

#Called every Frame, 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
