extends Area2D
class_name GameFuel, "res://Images/Pickups/Fuel.png"


onready var taken := false


func _on_Fuel_body_entered(body: Node) -> void:

	if body.is_in_group("player") and not taken:
		var player: GamePlayer = get_tree().get_current_scene().get_node("Player")

		if player and player.has_method("refuel"):
			player.refuel()
			$AnimationPlayer.play("pickup")
			$CollisionShape2D.set_deferred("disabled", true)
			taken = true


func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	queue_free()
