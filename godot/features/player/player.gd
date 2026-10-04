extends CharacterBody2D

const Tuning = preload("res://features/player/tuning.gd")
var tuning = Tuning.new()
# D3 swing geometry. The draw code and the hitbox are both derived from these
# three numbers, so the blade the player sees and the blade that kills cannot
# drift apart.
const ATTACK_PIVOT := Vector2(5.0, -18.0)
const ATTACK_ANGLE_START := -2.0943951023932  # -120 degrees: raised up and back
const ATTACK_ANGLE_END := 0.69813170079773    #  +40 degrees: down and forward
var enabled: bool = false
var tick: int = 0
var last_floor_tick: int = -1000
var jump_request_tick: int = -1000
var opportunity_consumed: bool = false
var require_jump_release: bool = true
var facing: float = 1.0
var jumps: int = 0
# D1/D2 (CHANGE-BRIEF 0.1.0 section 3): one extra jump and one dash per
# airborne period. Both budgets are refilled at exactly one place — floor
# contact in _physics_process — so "once per airborne period" cannot be
# refreshed in mid-air by any other event.
var air_jumps_left: int = 0
var dashes_left: int = 0
var dash_ticks_left: int = 0
var dash_dir: float = 1.0
var dashes: int = 0
# D3 (CHANGE-BRIEF revision 0.3.0): the sword swing.
var attack_ticks_left: int = 0
var attack_dir: float = 1.0
var attacks: int = 0
var attack_hitbox: Area2D
var attack_shape: CollisionShape2D
var test_control: bool = false
var test_axis: float = 0.0
var test_jump_pressed: bool = false
var test_jump_held: bool = false
var test_dash_pressed: bool = false
var test_attack_pressed: bool = false

func _ready() -> void:
	name = "Player"
	collision_layer = 2
	collision_mask = 1
	floor_snap_length = 1.0
	var shape := RectangleShape2D.new()
	shape.size = Vector2(18, 28)
	var collider := CollisionShape2D.new()
	collider.shape = shape
	collider.position = Vector2(0, -14)
	add_child(collider)
	# The swing hitbox. Layer 6 = PlayerAttack, mask layer 3 = Enemy, so it can
	# never interact with the world, the player, the hazards or the goal. It is
	# a blade-sized rectangle moved onto the blade each active tick rather than
	# a static box covering the whole arc.
	attack_hitbox = Area2D.new()
	attack_hitbox.name = "SwordArc"
	attack_hitbox.collision_layer = 32
	attack_hitbox.collision_mask = 4
	attack_hitbox.monitoring = false
	attack_shape = CollisionShape2D.new()
	var blade := RectangleShape2D.new()
	# 4.0 matches 2 * the drawn blade half-width below, so the hitbox is not
	# fatter than the blade the player sees (CHANGE-BRIEF 0.3.0 P5).
	blade.size = Vector2(tuning.attack_reach, 4.0)
	attack_shape.shape = blade
	attack_hitbox.add_child(attack_shape)
	add_child(attack_hitbox)

func reset_at(spawn: Vector2) -> void:
	position = spawn
	velocity = Vector2.ZERO
	last_floor_tick = -1000
	jump_request_tick = -1000
	opportunity_consumed = false
	require_jump_release = true
	test_jump_pressed = false
	test_dash_pressed = false
	test_attack_pressed = false
	jumps = 0
	air_jumps_left = tuning.air_jumps
	dashes_left = tuning.air_dashes
	dash_ticks_left = 0
	dashes = 0
	attack_ticks_left = 0
	attacks = 0
	_sync_attack_hitbox()
	queue_redraw()

## 0 = not swinging, 1 = windup, 2 = active (hitbox live), 3 = recovery.
func attack_phase() -> int:
	if attack_ticks_left <= 0:
		return 0
	var elapsed: int = tuning.attack_ticks - attack_ticks_left
	if elapsed < tuning.attack_windup_ticks:
		return 1
	if elapsed < tuning.attack_windup_ticks + tuning.attack_active_ticks:
		return 2
	return 3

## The blade's angle this tick. Held at the start angle through the windup,
## swept during the active window, held at the end angle through recovery.
func attack_angle() -> float:
	var elapsed := float(tuning.attack_ticks - attack_ticks_left)
	var windup := float(tuning.attack_windup_ticks)
	var active := float(tuning.attack_active_ticks)
	# Divide by active - 1 so the sweep REACHES its end angle on the last active
	# tick. Dividing by `active` capped t at 0.8, which left the blade above
	# y=301 for the whole live window and put the only ground-reaching angle in
	# recovery, where the hitbox is off. Enemies standing on the floor were
	# therefore unhittable, and no test noticed because every swing assertion
	# was about the hitbox tracking the blade rather than about what the blade
	# could reach.
	var span: float = maxf(1.0, active - 1.0)
	var t: float = 0.0
	if elapsed >= windup + span:
		t = 1.0
	elif elapsed > windup:
		t = (elapsed - windup) / span
	return lerpf(ATTACK_ANGLE_START, ATTACK_ANGLE_END, t)

func attack_tip() -> Vector2:
	return ATTACK_PIVOT + Vector2.from_angle(attack_angle()) * tuning.attack_reach

## The blade as a world-space segment this tick, mirrored the same way the
## drawing and the annotated hitbox are. Session uses this for the kill test
## because Area2D.overlaps_area() reports the PREVIOUS physics step, and the
## only active tick whose blade angle reaches a ground-level enemy is the last
## one - by the time the server could report it, monitoring is already off.
func attack_segment() -> PackedVector2Array:
	var a := ATTACK_PIVOT
	var b := attack_tip()
	if attack_dir < 0.0:
		a.x = -a.x
		b.x = -b.x
	return PackedVector2Array([position + a, position + b])

func _sync_attack_hitbox() -> void:
	if not is_instance_valid(attack_hitbox):
		return
	var live: bool = attack_phase() == 2
	attack_hitbox.monitoring = live
	if not live:
		return
	var a := ATTACK_PIVOT
	var b := attack_tip()
	var mid := (a + b) * 0.5
	var ang := (b - a).angle()
	if attack_dir < 0.0:
		# Mirroring about the body's vertical axis: (x, y) -> (-x, y) sends an
		# angle t to PI - t.
		mid.x = -mid.x
		ang = PI - ang
	attack_shape.position = mid
	attack_shape.rotation = ang

func _physics_process(delta: float) -> void:
	if not enabled:
		return
	tick += 1
	var axis := test_axis if test_control else Input.get_axis("move_left", "move_right")
	var held := test_jump_held if test_control else Input.is_action_pressed("jump")
	var pressed := test_jump_pressed if test_control else Input.is_action_just_pressed("jump")
	var dash_pressed := test_dash_pressed if test_control else Input.is_action_just_pressed("dash")
	var attack_pressed := test_attack_pressed if test_control else Input.is_action_just_pressed("attack")
	test_jump_pressed = false
	test_dash_pressed = false
	test_attack_pressed = false
	if not held:
		require_jump_release = false
	# The single refill point for every airborne budget.
	if is_on_floor() and velocity.y >= 0.0:
		last_floor_tick = tick
		opportunity_consumed = false
		air_jumps_left = tuning.air_jumps
		dashes_left = tuning.air_dashes
	if pressed and not require_jump_release:
		jump_request_tick = tick
	if not is_zero_approx(axis):
		facing = signf(axis)
	# D3 — sword swing. Ground or air, no movement effect, no invulnerability,
	# and no resources granted. A press during a swing is ignored. Facing is
	# locked for the duration so the drawn blade and the hitbox agree.
	# Count down BEFORE accepting a new press, so the press frame itself is
	# windup tick 0 and the phases come out 4 + 5 + 5 exactly. Counting down
	# first also means a press on the frame a swing ends starts the next one
	# with no dead frame in between.
	if attack_ticks_left > 0:
		facing = attack_dir
		attack_ticks_left -= 1
	if attack_pressed and attack_ticks_left <= 0:
		attack_ticks_left = tuning.attack_ticks
		attack_dir = facing
		attacks += 1
	# D2 — air dash. Refused while standing and while a dash is already
	# running. It grants no jump, and it confers no invulnerability: the
	# session's hazard overlap test is untouched, so a dash into the spikes
	# still kills.
	if dash_pressed and not is_on_floor() and dashes_left > 0 and dash_ticks_left <= 0:
		dashes_left -= 1
		dash_ticks_left = tuning.dash_ticks
		dash_dir = facing
		dashes += 1
	if dash_ticks_left > 0:
		# Locked horizontal speed with vertical motion suspended. Facing is
		# pinned to the direction the dash began in, so the sprite cannot face
		# backwards mid-dash. Gravity and the acceleration curve resume on the
		# tick the dash ends; the leftover speed then decays through the
		# starter's own deceleration, which is what gives the dash a tail.
		dash_ticks_left -= 1
		facing = dash_dir
		velocity.x = dash_dir * tuning.dash_speed
		velocity.y = 0.0
	else:
		var rate: float = tuning.acceleration if not is_zero_approx(axis) else tuning.deceleration
		velocity.x = move_toward(velocity.x, axis * tuning.speed, rate * delta)
		velocity.y = minf(velocity.y + tuning.gravity * delta, tuning.terminal_velocity)
	# The ground/coyote jump keeps precedence over the air jump, so a jump
	# inside the coyote window still spends the FIRST jump and leaves the air
	# jump in hand. A jump also cancels a running dash.
	if not opportunity_consumed and tick - last_floor_tick <= tuning.coyote_ticks and tick - jump_request_tick <= tuning.buffer_ticks:
		velocity.y = tuning.jump_velocity
		opportunity_consumed = true
		jump_request_tick = -1000
		dash_ticks_left = 0
		jumps += 1
	elif air_jumps_left > 0 and tick - jump_request_tick <= tuning.buffer_ticks:
		# D1 — the second jump, at the starter's unchanged jump_velocity.
		velocity.y = tuning.jump_velocity
		air_jumps_left -= 1
		jump_request_tick = -1000
		dash_ticks_left = 0
		jumps += 1
	_sync_attack_hitbox()
	move_and_slide()
	position.x = maxf(position.x, 10.0)
	queue_redraw()

## The rim colour. steel_edge, already in the eight-colour palette, so the
## dungeon rim costs no new colour (CHARACTER-SHEET section 3).
const RIM := Color("9aa7bd")

## The same rect, grown 1 px on every side, in rim colour.
func _mrect_o(x: float, y: float, w: float, h: float) -> void:
	_mrect(x - 1.0, y - 1.0, w + 2.0, h + 2.0, RIM)

## The same polygon, pushed 1.4 px out from its own centroid, in rim colour.
## Centroid expansion rather than true offsetting: for the four small convex
## shapes this is called on, the difference is under a pixel.
func _mpoly_o(points: PackedVector2Array) -> void:
	var c := Vector2.ZERO
	for p in points:
		c += p
	c /= float(points.size())
	var out := PackedVector2Array()
	for p in points:
		var d: Vector2 = p - c
		out.append((p + d.normalized() * 1.4) if d.length() > 0.01 else p)
	_mpoly(out, RIM)

func _mrect(x: float, y: float, w: float, h: float, c: Color) -> void:
	# One set of coordinates serves both facings: x is measured forward from the
	# body centre, and the rect is mirrored about that centre when facing left.
	var px: float = x if facing > 0.0 else -(x + w)
	draw_rect(Rect2(px, y, w, h), c)

func _mpoly(points: PackedVector2Array, c: Color) -> void:
	if facing > 0.0:
		draw_colored_polygon(points, c)
		return
	var flipped := PackedVector2Array()
	for i in range(points.size() - 1, -1, -1):
		flipped.append(Vector2(-points[i].x, points[i].y))
	draw_colored_polygon(flipped, c)

func _bar(a: Vector2, b: Vector2, half: float) -> PackedVector2Array:
	# A rectangle of thickness 2*half laid along the segment a->b, so the sword
	# is described by its endpoints instead of hand-computed corner arithmetic.
	var n := (b - a).orthogonal().normalized() * half
	return PackedVector2Array([a + n, b + n, b - n, a - n])

func _draw() -> void:
	# Original geometric art drawn with Godot vector calls — nothing imported,
	# traced, or derived from an existing commercial character. Deep-blue
	# armour, a light-blue visor slit that reads the facing direction, a purple
	# scarf that trails travel, and a back-slung blade that is drawn either
	# sheathed or swung, never both (CHANGE-BRIEF 0.3.0 P6).
	#
	# Collider contract: the 18x28 box spans x -9..9, y -28..0. The torso, helm,
	# shoulders and legs stay within its width -- the 1 px rim added in
	# revision 1.3 puts a single pixel outside it at x -10..10, which is
	# decoration and carries no hitbox, exactly like the scarf and the sword.
	# Measured extents are recorded in CHANGE-BRIEF revision 0.2.0.
	var plate := Color("1f3a6e")
	var shade := Color("16233d")
	var visor := Color("7fe3ff")
	var glint := Color("d8f7ff")
	var scarf := Color("8a5cf0")
	var scarf_tip := Color("6a3fbf")
	var steel := Color("4a5468")
	var steel_dark := Color("2a3246")
	var steel_edge := Color("9aa7bd")
	var grounded := is_on_floor()
	var stride: float = sin(float(tick) * 0.7) * 2.0 if grounded and absf(velocity.x) > 8.0 else 0.0
	var flutter: float = sin(float(tick) * 0.45) * 2.0
	var trail: float = 12.0 if grounded else 15.0
	var phase := attack_phase()

	# Rim pass (CONCEPT revision 1.3). On the cream backdrop the body read at
	# 10.03:1 and the dark `shade` shapes did the separating. Against a dungeon
	# wall the body is 1.60:1 and `shade` is 1.14:1, so the dark shading now
	# separates the character from nothing. A 1 px light halo is laid down
	# under everything; the body paints over its middle and only the rim
	# survives. The colour is steel_edge, already one of the eight -- 7.31:1
	# against the wall and 4.57:1 against the plate, so it reads against the
	# background AND against the body it outlines.
	_mrect_o(-5.0, -9.0, 4.0, 9.0 + stride)
	_mrect_o(1.0, -9.0, 4.0, 9.0 - stride)
	_mrect_o(-5.0, -20.0, 10.0, 11.0)
	_mrect_o(-5.0, -27.0, 10.0, 8.0)
	_mpoly_o(PackedVector2Array([Vector2(5.0, -19.0), Vector2(8.0, -15.0), Vector2(5.0, -11.0)]))
	_mpoly_o(PackedVector2Array([Vector2(-5.0, -20.0), Vector2(-9.0, -18.0), Vector2(-5.0, -15.0)]))
	_mpoly_o(PackedVector2Array([Vector2(5.0, -20.0), Vector2(9.0, -18.0), Vector2(5.0, -15.0)]))
	_mpoly_o(PackedVector2Array([Vector2(-5.0, -27.0), Vector2(-9.0, -24.0), Vector2(-5.0, -23.0)]))

	if phase == 0:
		# Sheathed: drawn first so the body occludes its middle and only the
		# grip and the scabbard tip protrude, which is what makes it read as
		# carried rather than held.
		var hilt := Vector2(-9.0, -32.0)
		var tip := Vector2(11.0, -4.0)
		var guard := hilt.lerp(tip, 0.22)
		var perp := (tip - hilt).orthogonal().normalized()
		_mpoly(_bar(guard, tip, 1.7), steel)
		_mpoly(_bar(guard.lerp(tip, 0.10), tip, 0.6), steel_edge)
		_mpoly(_bar(hilt, guard, 1.3), steel_dark)
		_mpoly(_bar(hilt.lerp(guard, 0.35), hilt.lerp(guard, 0.65), 1.4), scarf_tip)
		_mpoly(_bar(guard + perp * 2.9, guard - perp * 2.9, 0.9), steel_dark)

	# Scarf next: over the blade's middle, under the body.
	_mpoly(PackedVector2Array([
		Vector2(-2.0, -22.0), Vector2(-2.0, -16.0),
		Vector2(-trail + 2.0, -18.0 + flutter), Vector2(-trail, -23.0 + flutter),
	]), scarf)
	_mpoly(PackedVector2Array([
		Vector2(-trail + 2.0, -18.0 + flutter), Vector2(-trail, -23.0 + flutter),
		Vector2(-trail - 4.0, -20.0 + flutter * 1.5),
	]), scarf_tip)

	# Legs: longer than the starter's stubs. Stride keeps the starter's walk tell.
	_mrect(-5.0, -9.0, 4.0, 9.0 + stride, shade)
	_mrect(1.0, -9.0, 4.0, 9.0 - stride, shade)

	# Slim torso with a forward chest wedge for the lean, purple sash at the belt.
	_mrect(-5.0, -20.0, 10.0, 11.0, plate)
	_mpoly(PackedVector2Array([
		Vector2(5.0, -19.0), Vector2(8.0, -15.0), Vector2(5.0, -11.0),
	]), plate)
	_mrect(-5.0, -12.0, 10.0, 2.0, scarf)

	# Shoulder plates break the outline right at the collider edge.
	_mpoly(PackedVector2Array([
		Vector2(-5.0, -20.0), Vector2(-9.0, -18.0), Vector2(-5.0, -15.0),
	]), shade)
	_mpoly(PackedVector2Array([
		Vector2(5.0, -20.0), Vector2(9.0, -18.0), Vector2(5.0, -15.0),
	]), plate)

	# Helm, back-swept crest, and the visor slit. The slit sits forward of
	# centre so facing is readable from the head alone.
	_mrect(-5.0, -27.0, 10.0, 8.0, plate)
	_mpoly(PackedVector2Array([
		Vector2(-5.0, -27.0), Vector2(-9.0, -24.0), Vector2(-5.0, -23.0),
	]), shade)
	_mrect(-2.0, -25.0, 6.0, 2.0, visor)
	_mrect(3.0, -25.0, 2.0, 2.0, glint)

	if phase != 0:
		# Swung: drawn over the body, from the same pivot/angle/reach the
		# hitbox uses. The arc wedge only appears once the swing is live, so
		# the bright sweep marks exactly the ticks that can kill.
		var a := ATTACK_PIVOT
		var b := attack_tip()
		if phase >= 2:
			var wedge := PackedVector2Array()
			wedge.append(a)
			var samples := 7
			for i in range(samples + 1):
				var s: float = lerpf(ATTACK_ANGLE_START, attack_angle(), float(i) / float(samples))
				wedge.append(a + Vector2.from_angle(s) * tuning.attack_reach)
			_mpoly(wedge, Color(0.49, 0.89, 1.0, 0.28))
		_mpoly(_bar(a - Vector2.from_angle(attack_angle()) * 4.0, a, 1.3), steel_dark)
		_mpoly(_bar(a, b, 2.0), steel)
		_mpoly(_bar(a.lerp(b, 0.14), b, 0.7), steel_edge)
