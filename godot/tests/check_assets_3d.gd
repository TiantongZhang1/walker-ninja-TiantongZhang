extends SceneTree
## A3 — headless check for the three glTF assets.
##
## Loads each .glb, instances it, and prints the four numbers CHANGE-BRIEF
## revision 3.0.0 predicts about: bounding-box size in metres, node scale, the
## axis the asset stands along, and how far its lowest point sits from y = 0.
##
## Run (Windows, Git Bash):
##   "$GODOT" --headless --path godot --script res://tests/check_assets_3d.gd
## The chapter's macOS line wraps this in `timeout 120 ... --fixed-fps 60`;
## neither is needed here because this script calls quit() itself and never
## advances a frame.
##
## WHAT THIS CHECK DOES NOT SHOW. It measures geometry as Godot received it:
## size, orientation, scale, and where the origin sits. It says nothing about
## whether an asset READS as a torch, a trap or a slime, whether the colours
## survived the export, whether it looks right under the game's lighting, or
## whether it suits the style. Every one of those is a human check, and
## TEST-REPORT.md records them separately. A green run here is necessary and
## nowhere near sufficient.

const MODEL_DIR := "res://assets/models/"

## name -> [file, expected Godot-space size (x=W, y=H, z=D) in metres]
## Blender X -> Godot X, Blender Z -> Godot Y, Blender Y -> Godot Z (+Y up).
const EXPECTED := {
	"A3-TORCH": ["torch.glb", Vector3(0.22, 0.70, 0.22)],
	"A3-SPIKE": ["spike_trap.glb", Vector3(1.50, 1.00, 0.50)],
	"A3-SLIME": ["slime.glb", Vector3(1.375, 1.00, 1.375)],
}

const SIZE_TOL := 0.05      # +/- 5 %, as the brief's P2 states
const ORIGIN_TOL := 0.001   # metres, as the brief's P3 states

var failures := 0


func _init() -> void:
	print("A3 asset check — Godot %s" % Engine.get_version_info()["string"])
	print("Expected values come from CHANGE-BRIEF.md revision 3.0.0.\n")

	for asset_name: String in EXPECTED:
		_check(asset_name, EXPECTED[asset_name][0], EXPECTED[asset_name][1])

	print("\n%s" % ("ALL CHECKS PASSED" if failures == 0 else "%d CHECK(S) FAILED" % failures))
	print("Geometry only. Whether these read as what they are is a human check.")
	quit(0 if failures == 0 else 1)


func _check(asset_name: String, file: String, want: Vector3) -> void:
	var path := MODEL_DIR + file
	print("--- %s  (%s)" % [asset_name, path])

	if not ResourceLoader.exists(path):
		_fail("file not imported or missing: %s" % path)
		print("")
		return

	var packed := load(path) as PackedScene
	if packed == null:
		_fail("loaded, but not a PackedScene: %s" % path)
		print("")
		return

	var root := packed.instantiate()
	get_root().add_child(root)

	var aabb := _world_aabb(root)
	if aabb.size == Vector3.ZERO:
		_fail("no MeshInstance3D with geometry found")
		root.queue_free()
		print("")
		return

	var size := aabb.size
	print("  bounding box   %.3f x %.3f x %.3f m   (W x H x D)" % [size.x, size.y, size.z])
	print("  expected       %.3f x %.3f x %.3f m   (brief 3.0.0)" % [want.x, want.y, want.z])

	# P2 — size, +/- 5 %
	for axis in range(3):
		var got: float = size[axis]
		var exp: float = want[axis]
		var off: float = absf(got - exp) / maxf(exp, 0.0001)
		if off > SIZE_TOL:
			_fail("%s is %.1f%% off on %s (%.3f vs %.3f)" % [
				asset_name, off * 100.0, ["W", "H", "D"][axis], got, exp])

	# P1 — which axis it stands along
	var tallest := "Y"
	if size.x > size.y and size.x >= size.z:
		tallest = "X"
	elif size.z > size.y and size.z > size.x:
		tallest = "Z"
	var upright_axis := "Y"
	var want_tallest := "Y" if want.y >= maxf(want.x, want.z) else ("X" if want.x >= want.z else "Z")
	print("  longest axis   %s   (brief implies %s)" % [tallest, want_tallest])
	if tallest != want_tallest:
		_fail("%s is longest along %s, brief implies %s — check +Y Up on export" % [
			asset_name, tallest, want_tallest])
	print("  height along %s  %.3f m" % [upright_axis, size.y])

	# P4 — transforms applied
	var node3d := root as Node3D
	if node3d == null:
		_fail("root is not a Node3D")
	else:
		var sc := node3d.scale
		print("  node scale     (%.4f, %.4f, %.4f)" % [sc.x, sc.y, sc.z])
		if not sc.is_equal_approx(Vector3.ONE):
			_fail("%s node scale is not (1,1,1) — transforms were not applied" % asset_name)

	# P3 — origin: lowest point should sit on y = 0
	print("  lowest point   y = %+.4f m   (0 means it sits on the floor)" % aabb.position.y)
	if absf(aabb.position.y) > ORIGIN_TOL:
		var how := "floats above" if aabb.position.y > 0.0 else "sinks below"
		_fail("%s %s the floor by %.4f m — origin is not at the base" % [
			asset_name, how, absf(aabb.position.y)])

	root.queue_free()
	print("")


## Union of every MeshInstance3D AABB, expressed in the instanced root's space.
func _world_aabb(node: Node) -> AABB:
	var out := AABB()
	var seeded := false
	for n: Node in _walk(node):
		var mi := n as MeshInstance3D
		if mi == null or mi.mesh == null:
			continue
		var local := mi.get_aabb()
		# Transform relative to the instanced root, not to the whole tree.
		var xform := mi.global_transform
		var root3d := node as Node3D
		if root3d != null:
			xform = root3d.global_transform.affine_inverse() * mi.global_transform
		var box := xform * local
		if seeded:
			out = out.merge(box)
		else:
			out = box
			seeded = true
	return out


func _walk(node: Node) -> Array[Node]:
	var all: Array[Node] = [node]
	for child in node.get_children():
		all.append_array(_walk(child))
	return all


func _fail(msg: String) -> void:
	failures += 1
	print("  FAIL: %s" % msg)
