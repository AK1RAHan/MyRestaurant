extends Node3D

@onready var Player = $"../../Player"

func _process(delta: float) -> void:
	var tampilanIcon = Player.tampilkanIcon
