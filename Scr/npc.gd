extends CharacterBody3D

@onready var Player = $"../Player"
@onready var DialogText = $dialog
var urutan = 0
func _physics_process(delta: float) -> void:
	var tampilkanDialog = Player.tampilkanDialog
	var IndexDialog = [" ","Permisi saya ingin memesan!","Saya ingin memsan sebuah ayam goreng",]
	if tampilkanDialog:
		if Input.is_action_just_pressed("ui_accept"):
			if urutan < IndexDialog.size():
				DialogText.mesh.text = IndexDialog[urutan]
				urutan += 1
			else:
				tampilkanDialog = false
				urutan = 0
				DialogText.mesh.text = ""
