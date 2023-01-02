extends RigidBody2D
class_name GamePlayer, "res://Images/Car/RedCar.png"

const SPEED := 60_000
const ROTATION_SPEED := 6_000
const MAX_SPEED := 50
const MAX_FUEL := 100.0

var fuel := MAX_FUEL
var driving := false
var alive := true

onready var level: GameLevel = get_parent()
onready var wheels := get_tree().get_nodes_in_group("wheel")


func _ready() -> void:
	level.update_fuel(fuel)


func _physics_process(delta: float) -> void:
	driving = false

	if fuel > 0 and alive:
		$GameOverTimer.stop()

		if Input.is_action_pressed("ui_right"):
			driving = true
			apply_torque_impulse(-ROTATION_SPEED * delta * 60)

			for _wheel in wheels:
				var wheel: RigidBody2D = _wheel

				if wheel.angular_velocity < MAX_SPEED:
					wheel.apply_torque_impulse(SPEED * delta * 60)

		if Input.is_action_pressed("ui_left"):
			driving = true
			apply_torque_impulse(ROTATION_SPEED * delta * 60)

			for _wheel in wheels:
				var wheel: RigidBody2D = _wheel

				if wheel.angular_velocity > -MAX_SPEED:
					wheel.apply_torque_impulse(-SPEED * delta * 60)

	elif $GameOverTimer.is_stopped():
		$GameOverTimer.start()

	if driving:
		use_fuel(delta)
		$EngineSfx.pitch_scale = lerp($EngineSfx.pitch_scale, 2, 2 * delta)
	else:
		$EngineSfx.pitch_scale = lerp($EngineSfx.pitch_scale, 1, 2 * delta)


func refuel() -> void:
	fuel = MAX_FUEL
	level.update_fuel(fuel)


func use_fuel(delta: float) -> void:
	fuel -= 10 * delta
	fuel = clamp(fuel, 0, MAX_FUEL)
	level.update_fuel(fuel)


func _on_GameOverTimer_timeout() -> void:
	var _error = get_tree().reload_current_scene()


func _on_Head_body_entered(body: Node) -> void:
	print(body)
	alive = false
	$Head/HeadJoint.node_b = ""
