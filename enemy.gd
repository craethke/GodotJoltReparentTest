class_name Enemy
extends RigidBody3D

func _integrate_forces(_state: PhysicsDirectBodyState3D) -> void:
    # ---------------------------
    # This is the key trigger of the bug - commenting this out, the object
    # is no longer teleported to the origin on reparent.
    # ---------------------------
    test_move(global_transform, Vector3(0, -0.05, 0))

func die() -> void:
    var gun: Node3D = get_node("Gun")
    gun.reparent(get_tree().root)
