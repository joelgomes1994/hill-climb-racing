extends Node2D
class_name GameLevel


var coins_collected := 0

func _ready() -> void:
	pass


func add_coins(ammount: int) -> void:
	coins_collected += ammount
	$UI/Coin/Label.text = str(coins_collected)


func update_fuel(value: float) -> void:
	$UI/Fuel/ProgressBar.value = value
	var stylebox: StyleBoxFlat = $UI/Fuel/ProgressBar.get("custom_styles/fg")
	stylebox.bg_color.h = lerp(0, 0.3, value / 100)

	if $Player.fuel > 25.0:
		$UI/AnimationPlayer.play("fuel-idle")

	else:
		$UI/AnimationPlayer.play("fuel-alarm")

