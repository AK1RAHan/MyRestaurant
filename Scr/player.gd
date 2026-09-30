extends CharacterBody3D

const SPEED = 3.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.003  # Sensitivitas gerakan mouse

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var tampilkanIcon
var tampilkanDialog

@onready var IndexOfRay = [$Head/RayCast3D]
@onready var RayScn = $Head/RayCast3D
@onready var labelScn = $Control/Label
@onready var head: Node3D = $Head

func _ready() -> void:
	# Mengunci dan menyembunyikan kursor mouse ke tengah layar
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	# Menangani rotasi kamera saat mouse digerakkan
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		# 1. Putar badan karakter ke kiri / kanan (Yaw)
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		
		# 2. Putar kepala/kamera ke atas / bawah (Pitch)
		head.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		
		# 3. Batasi sudut tengok (clamp) agar tidak berputar 360 derajat ke belakang
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

	# Tekan tombol ESC untuk memunculkan kembali kursor mouse
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	
	for Ray in IndexOfRay:
		if Ray.is_colliding():
			var Collider = Ray.get_collider()
			if Collider and Collider.name == "Npc":
				labelScn.show()
				tampilkanDialog = true
				pass
			elif Collider and Collider.name == "Kompor":
				tampilkanIcon = true
				labelScn.show()
		else:
			tampilkanDialog = false
			tampilkanIcon = false
			labelScn.hide()
	
	# Gravitasi
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Input Arah WASD / Panah
	var input_dir := Input.get_vector("Kiri", "Kanan", "Maju", "Mundur")
	
	# Menyesuaikan arah jalan dengan arah pandang karakter/kamera
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
