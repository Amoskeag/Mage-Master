extends SpringArm3D

@onready var camera: Camera3D = $Camera3D
@export var turn_rate := 180.0
@export var mouse_sensitivity := 0.07

#Class Properties
var mouse_input: Vector2 = Vector2()
'''
You can also use Vector2(0, 0) or Vector2.ZERO to initialize the property. 
Vector2() works because both the x and y arguments have a default value of 0, 
so this is equivalent to Vector2(0, 0).
'''
@onready var player: Node3D = get_parent()
var camera_rig_height: float = position.y

func _ready() -> void:
	spring_length = camera.position.z
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

#Called every Frame, 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var look_input := Input.get_vector("view_right", "view_left", "view_down", "view_up" )
	look_input = turn_rate * look_input * delta
	look_input += mouse_input
	mouse_input = Vector2()
	rotation_degrees.x += look_input.y
	rotation_degrees.y += look_input.x
	rotation_degrees.x = clampf(rotation_degrees.x, -70, 50)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#var mouse_input: Vector2 = event.relative
		mouse_input = event.relative * -mouse_sensitivity
	elif event is InputEventKey and event.keycode == KEY_ESCAPE:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	position = player.position + Vector3(0, camera_rig_height, 0)
