# SUBMISSION.md — Assignment 3

> The assignment's §5 asks for a specific list of fields. They are reproduced
> here verbatim and in order, so a reviewer can check them off without
> hunting. Assignment 2 answered the same kind of list in a file called
> something else and lost marks for it; this one uses the filename the
> assignment names.

```text
Assignment:                       Assignment 3 - Your First 3D Game Assets
                                  with Claude, the Blender MCP, and Blender
Student:                          Tiantong Zhang
Project name:                     walker-ninja-TiantongZhang
GitHub repository URL:            https://github.com/TiantongZhang1/walker-ninja-TiantongZhang
Git tag and submitted commit SHA: tag a3
                                  git rev-list -n1 a3   prints the commit
                                  (NOT git rev-parse --short a3, which prints
                                  the annotated tag object, a different SHA)
Source revision shown in the film: the same tag. The film's evidence ledger
                                  hashes the nine project files it draws on,
                                  so a changed file breaks the check rather
                                  than passing quietly.
Godot version, Blender version,
and operating system:             Godot 4.7.2.stable.official.ed1daf0bf
                                  Blender 5.2.2 LTS, build 2026-09-15
                                  Windows 11 Home China 10.0.26200 (x86_64)
The three assets and what each
is for:                           A3-TORCH, 0.22 x 0.70 x 0.22 m - the
                                    dungeon's light source, drawn in 2D by
                                    _draw_torch()
                                  A3-SPIKE, 1.50 x 1.00 x 0.50 m - the pop-up
                                    floor trap the warning sound is built
                                    around; four of them in the level
                                  A3-SLIME, 1.375 x 1.00 x 1.375 m - the
                                    ground enemy; six of the eleven
MCP project and version, or
"script route":                   MCP route, all three assets.
                                  mcp-for-blender 2.1.9 (PyPI package),
                                  Blender add-on 1.8, protocol 13.
                                  Two version numbers, both needed to
                                  identify the install. No script-route
                                  fallback was needed; the MCP connected.
My hand edit in Blender:          The slime's eyes. Both were too small to
                                  read beside a 1.75 m player, so I selected
                                  each eye cube in the viewport and scaled it
                                  with S, then nudged it down: Slime_Eye_1 to
                                  1.526 and Slime_Eye_2 to 1.570, both about
                                  27 mm lower. The asymmetry is deliberate
                                  and kept. Photographed in
                                  design/blender/hand-edit-slime-eye.png.
Checks run (command and result):  "$GODOT" --headless --path godot --import
                                  "$GODOT" --headless --path godot --script \
                                      res://tests/check_assets_3d.gd
                                  -> 12 measurements over 3 assets, 0
                                     failures, exit 0. Output in
                                     TEST-REPORT.md section A2.

                                  Human check, 2026-10-14, in the Godot
                                  editor: camera walked around each asset
                                  including from behind and below.
                                  -> "checked, no problems". One sentence,
                                     recorded as one sentence.
Final film URL and filename:      NewWalker3D_TiantongZhang.mp4 at
                                  [[ upload to OneDrive and paste the link ]]
Final film SHA-256:               cd19e3d4acba3c39d0c060da8031fc7e80feeb628dcef81d9137622bf4f788b2
Film length / size:               208.00 s (3:28), 13561812 bytes
                                  3840x2160, 30 fps, H.264 + AAC
Summary of my changes:            see below
Known limitations:                see below
Changed games since Assignment 2: no
```

## Summary of my changes

Assignment 3 adds a layer to the same repository rather than starting a new
one, which is what the assignment asks for from A2 onward. The 2D slice is
untouched: no level data, no sprite, no audio, no gameplay number.

Three assets were **built, not generated**. The assignment is explicit that a
downloaded model or an AI-generated mesh does not count, and the add-on's own
generators were one call away and left off — `get_addon_status` reports all
six libraries and generators off, machine-readably, and that output is quoted
in `SOURCES.md` §9. Eleven primitives, 210 triangles for all three, against a
course limit of six shapes and 500 triangles each.

Every size is derived rather than invented. The player's collider is 18 × 28
px and the project's convention is 16 px = 1 m, which puts the player at
1.75 m; the trap's width and height are the level file's own trap rect, the
slime's are `SLIME_SIZE`, and the torch's height is the handle rect in
`_draw_torch` plus its flame. `CHANGE-BRIEF.md` revision 3.0.0 names the
source line for each number and was committed **before** the first piece of
geometry existed.

The build scripts in `tools/blender/` are not transcriptions of what ran: the
MCP executed each file with `exec(open(path).read())`, so the committed script
is the code Blender executed, and the same file runs standalone as the
script-route fallback.

Two revisions came from looking rather than from a check, which is the
inspect-and-revise cycle the assignment asks for. The slime was built at
subdivision 1, passed every automated check, and had a visibly pointed apex
where the 2D game draws a smooth dome; it is subdivision 2 now, recorded as
`CHANGE-BRIEF.md` revision 3.0.1 rather than by editing 3.0.0. Then its eyes
turned out too small to read, which is the hand edit above.

## Known limitations

- **The check measures geometry and nothing else.** Size, orientation, node
  scale and origin height. Whether an asset reads as a torch, whether the
  colours look right under the game's lighting, whether a face is missing —
  none of that is testable here, and `TEST-REPORT.md` §A8 says so. The only
  evidence for those is one human check that is one sentence long, recorded as
  one sentence rather than expanded into findings nobody gave.
- **The check was wrong before any asset was.** Its first version read
  `global_transform` from nodes a script running in `_init()` has not put in
  the tree, got identity back for every one, and reported a correct asset as
  0.425 m below the floor. The assignment warns that an agent's check can
  prove less than it claims; this one proved nothing until it was fixed, and
  the failing numbers are kept in `TEST-REPORT.md`.
- **The assets are low-poly and visibly faceted.** Eight-sided cones and an
  icosphere at subdivision 2. That is the triangle budget spent where it
  shows, not an accident.
- **They are not in the 2D game.** They live in a scene of their own.
  Assignments 4 and 5 reuse that scene; wiring them in is not asked for yet.
- **The torch's glow is not in the asset.** The 2D version draws 16 nested
  discs in code; the `.glb` carries an emissive flame material and no light. A
  light belongs to a scene, not to a mesh — which is what the film's Your Turn
  beat asks the viewer to add.
- **Two of the film's three source excerpts are shown as rendered images
  rather than as code panels.** The evidence checker requires every ledger
  excerpt to resolve inside the Godot project, and the Blender build scripts
  live in `tools/`, where the assignment asks for them. Moving them to satisfy
  a checker would have been the wrong fix, so they are shown verbatim as
  images with their path and line numbers on screen, and hashed as result
  media instead.
- **Five of the film's thirteen beats waste their left half.** Assignment 2's
  limitation, unchanged: `GodotDevWorkbench` in `asset` mode lays out
  `{code}{image}` and a result beat may not carry a code excerpt, so the left
  panel renders empty. Every evidence image is composed to the panel's
  measured 1529 × 987 so the right half is at least full.
