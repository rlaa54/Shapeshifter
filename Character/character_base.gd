extends CharacterBody2D


var speed = 300.0

func _physics_process(delta):
	# 입력 처리
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	# 벨로시티 정규화 및 속도 적용
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	# 움직임 적용
	move_and_slide()
