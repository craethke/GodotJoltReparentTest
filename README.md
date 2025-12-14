Minimal reproduction example for https://github.com/godotengine/godot/issues/114002

The project is configured to use Jolt physics, and demonstrates an issue where calling `reparent` on a physics node causes it to be telepored to (0,0,0).

In the main scene, there are 3 (relevant) objects:
* An enemy (RigidBody3D with capsule shape)
* A gun (RigidBody3D, child of the Enemy)
* A bullet (RigidBody3D, positioned above the enemy)

When the scene starts, the bullet will fall on the enemy, causing a collision. The bullet script will call Enemy->Die().

The Die method will call `reparent` on the Gun, which will reparent it to the scene root.

Expected:
* The Gun will be reparented in the scene tree, and maintain its previous global position

Actual:
* The gun will be teleported to (0,0,0)

The below code is what triggers this bug; removing it will fix the issue completely:

```
func _integrate_forces(_state: PhysicsDirectBodyState3D) -> void:
    # ---------------------------
    # This is the key trigger of the bug - commenting this out, the object
    # is no longer teleported to the origin on reparent.
    # ---------------------------
    test_move(global_transform, Vector3(0, -0.05, 0))
```

It's unclear why this code would affect the position of nodes being reparented, as it's meant to be a read-only API that doesn't affect the physics state.
