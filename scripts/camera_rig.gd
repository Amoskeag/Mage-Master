extends SpringArm3D

@onready var camera: Camera3D = $Camera3D
@export var turn_rate := 180.0

func _ready() -> void:
	spring_length = camera.position.z
	

#Called every Frame, 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var look_input := Input.get_vector("view_right", "view_left", "view_down", "view_up" )
	look_input = turn_rate * look_input * delta
	rotation_degrees.x += look_input.y
	rotation_degrees.y += look_input.x
	rotation_degrees.x = clampf(rotation_degrees.x, -70, 50)
	
	
