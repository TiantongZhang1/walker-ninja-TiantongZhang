# A3-COMPLIANCE.md — the assignment's own words, as a checklist

**Why this file exists.** On Assignment 2 the gaps in this project were recorded
honestly inside the repository and still cost marks, because they were written
against *my own* standards rather than against the assignment's. Nobody walked
the rubric until after submission. This file is that walk, done first and done
again before delivery, so a gap is priced rather than merely noted.

Status column: `[ ]` not started · `[~]` in progress · `[x]` done and verified ·
`[!]` known gap, declared with its cost.

---

## 0. Hard minimums — missing any one of these forfeits a whole block

| | Requirement (assignment's words) | Status |
|---|---|---|
| H1 | Three simple assets, each **mainly basic shapes**, **≤ 6 basic shapes**, **≤ 500 triangles**, flat-colour material. No sculpting, textures, rigging, animation. | [ ] |
| H2 | **You build the geometry**, with Claude, in Blender. A downloaded model or an AI-generated mesh **does not count**. | [ ] |
| H3 | Poly Haven, Sketchfab, Poly Pizza, Hyper3D Rodin, Hunyuan3D, Tripo **all left off**. Never call `generate_3d`, `search_assets`, `import_asset`. | [x] verified — see §6 |
| H4 | Each asset exported as **binary glTF (`.glb`)** with **+Y Up** on. | [ ] |
| H5 | All three shown together in a **Godot 3D scene**: floor, one light, a camera, assets side by side at game scale. | [ ] |
| H6 | `CHANGE-BRIEF.md` committed **before the first build**, and **after** the "Learn the window" session. Ordering is itself scored. | [ ] |
| H7 | **At least one hand edit** made by the user with the mouse in Blender's window. | [ ] |
| H8 | Tag the submitted commit **`a3`**, push it, and **do not move it afterwards**. | [ ] |
| H9 | `SUBMISSION.md` with the assignment's **15 fields**, exactly that filename. | [ ] |
| H10 | Film shows the **real Blender session**, at least one **prompt and what it built**, and the **hand edit**. Reconstructions labelled as reconstructions. | [ ] |
| H11 | Film includes the **headless numbers beside the brief**, labelled as headless. | [ ] |
| H12 | Keep MP3, MP4 and >25 MB out of git; film to OneDrive, identified by filename and SHA-256. | [ ] |

**H9 is the one that already cost marks once.** Assignment 2 asked for
`SUBMISSION.md` by name and this project produced `CANVAS-NOTE.txt` instead.
Equivalent content under a different filename is not the deliverable.

---

## 1. Required files

### New for A3

| Path | Requirement | Status |
|---|---|---|
| `CHANGE-BRIEF.md` | A3 revision: three assets, sizes in metres justified against something in the game, origin and why, look, triangle budget, **≥ 3 predicted failure cases each with its check** | [ ] |
| `BLENDER-NOTES.md` | **Six** interface parts **in the user's own words** + **one screenshot of their own session** with an object selected | [ ] |
| `tools/blender/build_<asset>.py` | Every `execute_blender_code` body, saved — "or Git will not show how the asset was built" | [ ] |
| `<asset>.blend` ×3 | The Blender source for each asset, each built around the world origin, each in its own file | [ ] |
| `godot/**/*.glb` ×3 + `.import` | The exported assets and Godot's import sidecars | [ ] |
| Godot 3D scene | Floor, one light, a camera, three assets side by side | [ ] |
| `godot/tests/<check>.gd` | Headless check printing each asset's bounding-box size, node scale, and the axis it stands along | [ ] |
| `SUBMISSION.md` | The 15 fields, verbatim list in §4 | [ ] |
| `A3-COMPLIANCE.md` | This file, walked again before delivery | [~] |

### Carried forward and updated

| Path | What A3 adds | Status |
|---|---|---|
| `README.md` | Project name, **Godot + Blender + MCP versions**, how to run the check and open the scene, what this assignment added, known limitations, final-film link | [ ] |
| `TEST-REPORT.md` | The A3 check table in §3, with Blender and Godot versions | [ ] |
| `FRICTIONAL.md` | Dated entries; setup session already written | [~] |
| `SOURCES.md` | Blender + version, MCP project + version, every tool, what AI contributed | [ ] |

### Must NOT be committed

`.godot/` · `*.blend1` (Blender's own save-versions) · caches · credentials ·
`*.mp4` / `*.mp3` / anything over 25 MB

---

## 2. Order of work — the sequence is scored, not just the artefacts

1. `[ ]` **Learn the window.** User opens Blender and just looks: orbit, pan,
   zoom. Writes `BLENDER-NOTES.md` in their own words and takes their own
   screenshot. *"so your sizes and budget are informed guesses and not blind
   ones."*
2. `[ ]` **Commit `CHANGE-BRIEF.md`** — before asking Claude to build anything.
   *"Retain the original; add later revisions rather than rewriting it to make
   every prediction look right."*
3. `[ ]` **Build one asset per request**, plan first, `get_scene_info` before
   and after, apply rotation and scale, look at it in the viewport.
4. `[ ]` **Hand edit** by the user, with a note on what it taught them.
5. `[ ]` **Export** `.glb`, import into Godot, build the 3D scene.
6. `[ ]` **Check**, record in `TEST-REPORT.md`, do one documented
   inspect-and-revise cycle.
7. `[ ]` **Film**, then **tag `a3`**, then **Canvas**.

---

## 3. `TEST-REPORT.md` — the evidence table the assignment asks for

| Check | Evidence to collect | Status |
|---|---|---|
| Interface notes | Six parts in own words + one own screenshot | [ ] |
| Size | Blender sidebar dimensions **beside the brief**, and the Godot bounding-box numbers **beside both** | [ ] |
| Upright and scale | Stands the right way up in Godot; **node scale is 1,1,1 after export** | [ ] |
| Origin | Place each on the floor in Godot — does it sit, or float? | [ ] |
| Triangle count | Within budget. Blender status bar → right-click → Scene Statistics | [ ] |
| Imports and appears | All three import without errors and appear in the scene | [ ] |
| **HUMAN CHECK: look** | Walk the camera around each, **including from behind and below**. Do they read at game size? Missing faces, wrong colours? | [ ] |
| What Claude got wrong | **At least one thing**, or an honest "nothing, and here is how I checked" | [ ] |

Plus: *"Do not delete a failing assertion to turn a report green."*

**What the check cannot show** (the assignment says this twice, and the rubric
awards 3 points for being able to say it): a passing check shows the assets
arrived at the size, orientation and scale measured. It does **not** show they
look right under the game's lighting, read as what they are, or suit the style.

---

## 4. `SUBMISSION.md` — the 15 fields, verbatim

```
Assignment: Assignment 3 - Your First 3D Game Assets with Claude, the Blender MCP, and Blender
Student:
Project name:
GitHub repository URL:
Git tag and submitted commit SHA:
Source revision shown in the film:
Godot version, Blender version, and operating system:
The three assets and what each is for:
MCP project and version, or "script route" (and which assets used which):
My hand edit in Blender:
Checks run (command and result):
Final film URL and filename:
Final film SHA-256:
Summary of my changes:
Known limitations:
Changed games since Assignment 2 (yes/no; if yes, FRICTIONAL.md entry):
```

Answers already fixed:

- **Project name:** `walker-ninja-TiantongZhang`
- **Changed games since Assignment 2:** **no** — confirmed by the user on
  2026-10-14, inside the "once, before Assignment 4" window the assignment
  allows.
- **Godot / Blender / OS:** Godot 4.7.2 · Blender **5.2.2 LTS** (build
  2026-09-15) · Windows 11 Home China 10.0.26200
- **MCP project and version:** `mcp-for-blender` **2.1.9** (PyPI package);
  Blender add-on reports **1.8**; protocol 13. Two version numbers, both needed.

**Do not put the submitted commit's own SHA inside that commit.** The
assignment says so, and A2 burned three commits learning it. Tag `a3`, then
read it with `git rev-list -n1 a3` — *not* `git rev-parse --short a3`, which
prints the annotated tag object instead of the commit.

---

## 5. Rubric, with where each point is earned

### Implementation and explanation — 60

| Pts | Criterion | Where it comes from | Status |
|---|---|---|---|
| 6 | Three assets chosen for the game and **specified in numbers** | `CHANGE-BRIEF.md` | [ ] |
| 4 | **≥ 3 predicted failure cases, each with its check** | `CHANGE-BRIEF.md` | [ ] |
| 8 | **MCP route working for ≥ 2 assets**, code kept in `tools/blender/` | MCP transcript + saved scripts | [ ] |
| *(6)* | *Fallback if MCP would not connect in the 2-hour box: honest specific account + working script route. Caps at 6, not 8.* | `FRICTIONAL.md` | n/a — MCP connected |
| 3 | Interface notes **in own words** with **own screenshot** | `BLENDER-NOTES.md` | [ ] |
| 3 | **≥ 1 hand edit** and what it taught | `FRICTIONAL.md` + `BLENDER-NOTES.md` | [ ] |
| 18 | The three assets, 6 each: recognisable (2) · size, upright, origin, transforms applied (3) · clean material (1) | the `.glb` files | [ ] |
| 4 | All three import and appear **at game scale** | Godot scene | [ ] |
| 3 | Numbers match the brief **and you can say what the check does and does not show** | `TEST-REPORT.md` | [ ] |
| 3 | An **evidence-based revision** and an **honest limitation** | `FRICTIONAL.md` + `TEST-REPORT.md` | [ ] |
| 8 | Explainer: workflow and assets (3) · real Blender session **and** Godot scene shown (3) · traceable evidence and stated limits (1) · readable, audible, required workflow (1) | the film | [ ] |

### Frictional — 10

| Pts | Criterion | Status |
|---|---|---|
| 3 | Specific, honest accounts of what was tried and what happened | [~] setup session written |
| 3 | What was checked, changed or learned in response, **including unresolved questions** | [~] |
| 2 | Explicit **human / AI** contributions: accepted, modified, rejected | [ ] |
| 2 | Traceability to commits, prompts, tests, observations | [~] |

*"An unsuccessful attempt can earn full Frictional credit… If something worked
immediately, say so and explain how you checked it."*

### GitHub matching Canvas — 10

| Pts | Criterion | Status |
|---|---|---|
| 4 | Required, accessible source and documentation actually posted | [ ] |
| 3 | Canvas identifies the **`a3` tag and the exact commit**, matching files, clear run instructions | [ ] |
| 3 | Accessible film link, identified media version, evidence corresponds to the submitted game | [ ] |

### Relative Quartile — 20

Assigned by comparison with the class. **Not predictable — say so rather than
estimate it.** *"A plain, precise explanation outranks a beautiful one that
misrepresents the work."*

---

## 6. Verified so far

Machine-readable, from `get_addon_status` and `execute_blender_code` against
the live Blender on 2026-10-14. These are measurements, not quotations from the
assignment.

| Fact | Value | How |
|---|---|---|
| Blender | `5.2.2 LTS` (build 2026-09-15) | `get_addon_status` |
| Add-on | `1.8`, `up_to_date: true`, protocol 13 = expected 13 | `get_addon_status` |
| MCP package | `mcp-for-blender` 2.1.9 | `uvx --from mcp-for-blender …` |
| **Asset libraries** | polyhaven **off** · sketchfab **off** · polypizza **off** | `get_addon_status` |
| **Generators** | tripo **off (Premium only)** · hunyuan3d **off** · hyper3d **off** | `get_addon_status` |
| Premium generators | `[]` — none available | `get_addon_status` |
| Telemetry | `telemetry_consent: false` | `get_addon_status` |
| Unit system | `METRIC`, `scale_length = 1.0` → **1 unit = 1 m** | `scene.unit_settings` |
| **`export_yup` default** | **`True`** — +Y Up is on by default here too | glTF operator RNA |
| `export_apply` default | `False` (Apply Modifiers off) | glTF operator RNA |
| `export_format` default | **`''`** — calling the exporter from Python **must** pass `export_format='GLB'` | glTF operator RNA |
| glTF add-on | `(5, 2, 40)` | `addon_utils.modules()` |
| Socket binding | `host='localhost', port=9876` | `blender_mcp.py:1184` |

**H3 is satisfied and machine-checked.** All six named services report off. Note
that `get_addon_status` *does* list Tripo — as `off (Premium only)` — even
though the add-on's N-panel shows no checkbox for it. An earlier note in this
project said Tripo was absent from version 1.8; that was true of the panel and
wrong about the software.

---

## 7. Only the user can do these

No amount of tooling substitutes for them, and the rubric pays for them.

- `[ ]` The **"Learn the window"** session and the six parts in their own words
- `[ ]` Their **own screenshot** of their own Blender session, object selected
- `[ ]` **At least one hand edit** with the mouse, and what it taught them
- `[ ]` **HUMAN CHECK** — walking the camera around each asset, from behind and
  below, judging whether it reads
- `[ ]` Watching the finished film
- `[ ]` The **2-hour MCP time box** is a rule about *their* attempt

---

## 8. Open questions — answer before delivery

All three answered by the user on 2026-10-14.

| | Answer |
|---|---|
| A1 | **Due tomorrow night, 2026-10-15.** About 24 hours. The film is the schedule risk, not the modelling — see the note below. |
| A2 | **The user pushes to the instructor's course repository themselves.** Not this session's task. |
| A3 | **Torch · spike trap · slime.** All three are things the 2D game already draws in code, so each has a real in-game size to be justified against. |

### The 24-hour note

The assignment is explicit that a small film is acceptable: *"A short, plain
film is fine"*, *"Duration follows the explanation, with no minimum"*, and the
explainer is **8 points of 100**. Assignment 2's film consumed more time than
everything else in that assignment combined. Here it must not: build the
assets, get the Godot scene and the checks right, then make a short film about
what was actually done.

Points at risk if time runs out, in the order they should be defended:
`CHANGE-BRIEF.md` before building (10) and the three assets themselves (18) are
worth more than a polished film (8), and the ordering points cannot be
recovered later at any price.

---

## 9. Pre-delivery gate

Walk this file again, top to bottom, before tagging `a3`. Then:

```bash
git clone <repo> ../a3-check && git -C ../a3-check checkout a3
```

Import once, run the check, open the scene **in the clone** — *"A working local
folder is not proof that everything was posted."* Confirm the film depicts that
source.

Anything still `[!]` at that point gets written into `SUBMISSION.md` under
**Known limitations**, with what it costs, in the assignment's own terms.


---

## 10. Sizes, derived from the game rather than invented

The brief has to justify each size *"against something in your game (the
player's height, a tile, a door)"*. The anchor is the player's collider, which
`features/player/player.gd:67` sets to **18 x 28 px**, and the scale convention
is **16 px = 1 m**, which puts the player at **1.125 x 1.75 m** — a human
height, so every other number inherits a sanity check.

| Asset | In-game source | px | metres (16 px = 1 m) |
|---|---|---|---|
| Player (anchor, not an asset) | `player.gd:67` collider | 18 x 28 | 1.125 x **1.75** |
| **Spike trap** | `levels/first_steps.json` trap rect `[1160, 304, 24, 16]` | 24 x 16 | **1.5 x 1.0** |
| — one tooth | `SPIKE_PITCH = 8`, base to tip = rect height | 8 x 16 | 0.5 x 1.0 |
| **Slime** | `session.gd:308` `SLIME_SIZE = Vector2(22, 16)` | 22 x 16 | **1.375 x 1.0** |
| **Torch** bracket | `session.gd` `_draw_torch`: `draw_rect(cx-1, cy, 2, 10)` | 2 x 10 | 0.125 x 0.625 |
| — flame | flame polygon spans x -3..+3, y cy-7..cy+1 | 6 x 8 | 0.375 x 0.5 |
| — glow (not geometry) | 16 nested discs, outer radius 60 | 120 across | 7.5 across |

The spikes stand at 57 % of the player's height and the slime at the same, which
is what the 2D game already shows; the proportions are not being invented for
3D, they are being carried across.

**Triangle budgets** (course limit: 500 each, 6 basic shapes each). The
assignment warns that *"A Blender sphere or cylinder at its default settings
can use a large share of that budget, so ask Claude to lower the segment
counts."* Planned, to be confirmed by measurement after building:

| Asset | Shapes | Rough tris |
|---|---|---|
| Torch | handle cylinder + bracket cylinder + flame cone + flame core = 4 | ~150 |
| Spike trap | base plate cube + 3 tooth cones = 4 | ~55 |
| Slime | squashed icosphere (subdiv 1) + 2 eyes = 3 | ~105 |

A cylinder at N sides costs `4N - 4` triangles and a cone `2N - 2`, so 8 sides
is the knob to turn if any of these comes in over budget.
