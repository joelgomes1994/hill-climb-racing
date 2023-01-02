tool
extends Area2D
class_name GameCoin, "res://Images/Pickups/Coin5.png"

enum CoinValue {
	FIVE = 5,
	TEN = 10,
	TWENTY_FIVE = 25,
	FIFTY = 50,
}

export(CoinValue) var value = CoinValue.FIVE setget _set_coin_sprite

onready var taken := false


func _ready() -> void:
	if Engine.is_editor_hint():
		pass


func _set_coin_sprite(new_value: int):
	value = new_value
	$Sprite.set_texture(load("res://Images/Pickups/Coin" + str(new_value) + ".png"))


func _on_Coin_body_entered(body: Node) -> void:

	if body.is_in_group("player") and not taken:
		var cur_scene: GameLevel = get_tree().get_current_scene()

		if cur_scene.has_method("add_coins"):
			cur_scene.add_coins(value)
			$AnimationPlayer.play("pickup")
			$CollisionShape2D.set_deferred("disabled", true)
			taken = true


func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	queue_free()
