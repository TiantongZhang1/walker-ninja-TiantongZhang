# FACTCHECK.md — every number the narration says, and where it came from

One row per claim. "Where" is a thing a reviewer can re-run or re-read.

## B00 — the ask

| claim | evidence |
|---|---|
| "a reconstruction, not a transcript" | True by construction; the running text says it on screen and the narration says it in the first sentence. No build receipt is shown. |
| "three things it already draws in code" | `_draw_torch()`, `_draw_spikes()`, `_draw_slime()` in `game/session.gd`. |

## B01 — built, not generated

| claim | evidence |
|---|---|
| "eleven primitives" | 4 + 4 + 3, reported by each build script's `report()`. |
| "two hundred and ten triangles for all three" | 84 + 54 + 72 = 210, from `mesh.calc_loop_triangles()`. |
| "a 3D generator was available in the same add-on" | `get_addon_status` lists `hyper3d`, `hunyuan3d`, `tripo`. All report off. |

## B02 / B03 — the trap

| claim | evidence |
|---|---|
| The excerpt is `build_spike_trap.py` 98–111 verbatim | `gamedev-evidence.json` → `excerpts[B02]`, hash-bound. Sliced from the file by line range at build time. |
| "spike_count is the rect width over the pitch, twenty-four over eight, three" | `session.gd:213` `maxi(1, int(rect.size.x / SPIKE_PITCH))`, `SPIKE_PITCH = 8`, rect width 24. |
| "fifty-four triangles" | `report()` output, and the Godot check. |
| "one point five metres wide and one metre tall" | `levels/first_steps.json` `[1160, 304, **24, 16**]` at 16 px = 1 m. |

## B04 / B05 — the slime

| claim | evidence |
|---|---|
| The excerpt is `build_slime.py` 98–109 verbatim | `excerpts[B04]`, hash-bound. |
| "missed its own brief by fifteen per cent" | Measured 1.171 against 1.375 = 14.8 % under. The first build's own output. |
| "a dome built at one point three seven five measured one point one seven" | Same. The `fit:` line prints both. |
| "twenty more triangles" | 52 → 72, both from `report()`. |
| "still inside the budget the brief wrote down" | `CHANGE-BRIEF.md` 3.0.0 budgets 120 for this asset. |
| "Every check passed on the one on the left" | It did. The pointed version passed size, axis, scale and origin; that is the point of the beat. |

## B06 / B07 — the check

| claim | evidence |
|---|---|
| The excerpt is `check_assets_3d.gd` 150–161 verbatim | `excerpts[B06]`, hash-bound. |
| "reported a correct asset as sunk four hundred millimetres into the floor" | The failing run: `lowest point y = -0.4250 m`. `TEST-REPORT.md` §A8. |
| "0.850 m tall and -0.425 m low: exactly the cone's local half-height" | Tooth height 0.85, centred on its own origin → ±0.425. |
| "Twelve measurements, no failures" | 3 assets × 4 (size, axis, scale, origin). The run's output is B07's image. |

## B08 — the hand edit

| claim | evidence |
|---|---|
| "my own Blender" | `design/blender/hand-edit-slime-eye.png`, the author's screenshot; the title bar names the file. |
| "scale 1.526 … 1.570 … about 27 mm lower" | Measured through the MCP before the transform was applied; the screenshot's Properties panel shows the resulting position to five decimals. |
| "a scale of one, because the transform was applied afterwards" | Visible in the same screenshot: 缩放 1.000 on all three axes. |

## B09 — the scene

| claim | evidence |
|---|---|
| "one point nine metres apart" | `asset_showcase.tscn`, the three transforms at x −1.9, 0, +1.9. |
| "each origin is at the centre of its underside" | `CHANGE-BRIEF.md` 3.0.0, and the check's `lowest point y = +0.0000 m` on all three. |
| "the WorldEnvironment is ambient, not a second light" | The scene has one light node. The environment sets `ambient_light_energy = 0.25`. |

## B10 / B11 — verdict and turn

| claim | evidence |
|---|---|
| "all six libraries and generators off" | `get_addon_status`, quoted in `SOURCES.md` §9. |
| "one human check, one sentence long" | `TEST-REPORT.md` §A6, which quotes it in full and says it is one sentence. |
| "sixteen nested discs with an outer radius of sixty pixels" | `session.gd` `_draw_torch()`: `range(16)`, `60.0 - i * 3.6`. |
| "three point seven five metres of reach" | 60 px ÷ 16 px/m = 3.75 m. Stated as a prediction for the viewer to test, not as a measurement. |

## Corrections made while building this film

| | |
|---|---|
| The slime's subtitle ran under its own image | Caught by looking at the composed evidence file; the images start 26 px lower now. |
| An earlier note said add-on 1.8 has no Tripo | True of the N-panel, false of the software. `get_addon_status` lists it as Premium-gated and off. Corrected in `SOURCES.md` §9 and `FRICTIONAL.md`. |
