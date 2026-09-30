extends CharacterBody3D

@onready var Player = $"../Player"
@onready var DialogText = $dialog
var urutan = 0
func _physics_process(delta: float) -> void:
	var tampilkanDialog = Player.tampilkanDialog
	var IndexDialog = [" ","Halo Cuy", "Nama gw Ucok!", "Salken Cuhh", ""]
	if tampilkanDialog:
		if Input.is_action_just_pressed("ui_accept"):
			urutan += 1
			DialogText.mesh.text = IndexDialog[urutan]
	if urutan >=4:
		urutan =0
			
	pass
