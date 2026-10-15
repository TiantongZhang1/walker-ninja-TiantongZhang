# COMPONENTS.md — what this film takes apart

Five units, each one a thing that exists in the repository and can be opened.
This is Assignment 3's layer only; the 2D game is Assignment 2's film.

## 1. `tools/blender/build_spike_trap.py` — the trap

Four primitives: a cube plate and three cones. The tooth count is derived, not
chosen — the 2D `spike_count()` is `rect.size.x / SPIKE_PITCH`, 24 / 8 = 3 —
and the pitch in the script is the width over that same count, so the asset
and the thing it represents come out of one number.

**Data in:** `levels/first_steps.json` trap rect `[1160, 304, 24, 16]`, at the
project's 16 px = 1 m. **Out:** `godot/assets/models/spike_trap.glb`, 54
triangles. **Trade-off:** 8-sided cones are visibly faceted close up; a cone
costs `2N − 2` triangles and the budget is 500.

## 2. `tools/blender/build_slime.py` — the slime, and `fit_to_size()`

Three primitives: an icosphere bisected at z = 0 and hole-filled, plus two eye
cubes. The unit worth teaching is `fit_to_size()`: an icosphere is a faceted
solid with no vertex ring on the cut plane, so a dome built at a nominal
1.375 m measured 1.171. The function measures the mesh after the cut and
scales it to the brief.

**Trade-off:** six lines and one extra pass over the vertices, against a size
that no longer depends on the subdivision level. It paid for itself the same
day, when `SUBDIV` went 1 → 2 and the size did not move.

## 3. `tools/blender/export_glb.py` — the export settings, written once

Shared by all three so they cannot drift. Two settings are passed explicitly
rather than inherited: `export_format='GLB'`, whose operator default is the
**empty string** — calling the exporter from Python without it produces no
file — and `export_yup=True`, which is already the default here but which the
brief's first prediction depends on.

## 4. `godot/tests/check_assets_3d.gd` — the check, and what it cannot do

Loads each `.glb`, walks it accumulating local transforms, and prints the
bounding box, the longest axis, the node scale and the distance from the floor
against the brief. Exits non-zero on any mismatch.

Its first version read `global_transform` from nodes that a script running in
`_init()` has not put in the tree, got identity back for every one, and
reported a correct asset as sunk 0.425 m into the floor. That is in the film
because the assignment warns an agent's check can prove less than it claims.

## 5. `godot/scenes/asset_showcase.tscn` — the scene

Floor, one `DirectionalLight3D`, one `Camera3D`, three assets 1.9 m apart, all
at y = 0. The `WorldEnvironment` supplies flat ambient and is not a second
light; without it an unlit face reads as a hole and the human check cannot be
performed.

## Not in this film

The 2D slice — level, sprites, audio, gameplay. Assignment 2's film covers it
and nothing in A3 changed it. `BLENDER-NOTES.md`'s six interface parts are
coursework, not a component. The three `.blend` files are sources, shown
through their build scripts rather than as files.
