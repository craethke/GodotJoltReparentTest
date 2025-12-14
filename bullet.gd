extends RigidBody3D

func _on_body_entered(body: Node) -> void:
    if body is Enemy:
        body.die()
    
    queue_free()
