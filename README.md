# walker-ninja-TiantongZhang

**CSYE 7270, Assignment 2 — Generate Art, Sound, and Music for Your Game.**
Tiantong Zhang · `zhang.tiant@northeastern.edu`

A 2D side-scrolling dungeon slice: a cyber-ninja with a double jump, an air
dash and a sword, against pop-up spike traps, patrolling slimes and flying
horses. It continues the Assignment 1 build rather than starting a new game.

| | |
|---|---|
| Engine | Godot **4.7.2.stable.official** `ed1daf0bf`, GL Compatibility |
| Resolution | 640 × 360 logical, 1280 × 720 windowed, `canvas_items` stretch |
| Physics | 60 Hz fixed |
| Automated checks | **110 — 0 failures** |

---

## Run it

Double-click **`run-game.bat`**.

There is no standalone `.exe` — this is a Godot project, so the editor binary
runs it from `godot/project.godot`. The `.bat` finds Godot relative to itself,
so moving the whole course folder is fine; separating this repository from the
Godot download is not, and if that happens the script says where it looked
instead of flashing a console and vanishing.

By hand, if you prefer:

```bash
"…/Godot_v4.7.2-stable_win64.exe" --path godot
```

### Controls

| | |
|---|---|
| `A` / `D` or arrows | move |
| `Space` | jump — once more in the air |
| `Shift` | air dash — **air only, once per airborne period, not invincible** |
| Left click | sword swing |
| **`0`** | **mute everything** |
| `R` | retry |
| `Esc` / `P` | pause |
| `Enter` | start · resume · play again |
| `M` | main menu, from pause or the results screen |

---

## What Assignment 2 added

| | state |
|---|---|
| **Music** — a 16-bar loop, on its own bus, surviving retries without restarting | **done**, generated (Suno `v6-mini`) |
| **A mute key**, on the Master bus, with a HUD indicator | **done** |
| **A dungeon setting** — stone wall, mortar courses, blind arches, wall torches, torchlit platform edges | **done**, original vector art |
| **A character with parts** — head, torso, two arms, two legs, directional rim light | **done**, original vector art |
| **A death pose** — prone, face down, the only pose wider than it is tall | **done**, original vector art |
| **Four sound effects** — jump, slash, trap warning, death | **wired; the audio is a placeholder, not generated** |
| **Generated art** | **not started.** Specified in `CHARACTER-SHEET.md`; no image has been generated |
| **The film** | not started |

`SOURCES.md` is the authoritative answer to *which of these did you actually
generate*. `godot/assets/README.md` is the one-table version.

---

## Verify it

```bash
GODOT="…/Godot_v4.7.2-stable_win64.exe"

"$GODOT" --headless --path godot --script res://tests/test_game.gd      # 96 checks
"$GODOT" --headless --path godot --script res://tests/test_keyboard.gd  # 14 checks
```

Both print one JSON object per check with **what it observed**, a final count,
and exit non-zero on any failure. Full results, including the numbers and the
three defects they caught, are in **`TEST-REPORT.md`**.

To regenerate the rendered evidence (these need a window — and note that
`--quit-after` counts *process* frames, not physics ticks, which is why the
number is large):

```bash
"$GODOT" --path godot --script res://tests/capture_game.gd      --quit-after 200000
"$GODOT" --path godot --script res://tests/capture_character.gd --quit-after 200000
"$GODOT" --path godot --script res://tests/capture_enemies.gd   --quit-after 200000
python scripts/check_trap_visibility.py     # spike drawn only while lethal
python scripts/check_enemy_visibility.py    # enemies drawn at their live positions
python scripts/build_char_sheet.py          # the 11-pose contact sheet
python scripts/synth_placeholder_sfx.py     # re-synthesise the placeholder effects

# once a pose has been generated -- see PROMPTS.md
python scripts/import_pose.py design/character/CHAR-P1.png --id p1-idle
```

Requires Python 3.12 with numpy, scipy and Pillow, plus `ffmpeg` on PATH.

---

## Read it

Written in this order, and the order is the point — each one is append-only, so
revisions are added and earlier text is never rewritten.

| file | what it is |
|---|---|
| **`CONCEPT.md`** | the game in one page, four design pillars, then revisions 1.1–1.4 as each decision landed: the music's feel, the art style, the dungeon, the character rebuild |
| **`CHARACTER-SHEET.md`** | the generation spec — palette with measured contrast ratios, 11 poses mapped to states the code can actually distinguish, and the acceptance order a generated frame has to survive |
| **`STORYBOARD.md`** | six panels on the level's own signage, with the method and per-panel coordinates, plus seven hand-drawn frames |
| **`CHANGE-BRIEF.md`** | what changed in the code, revision by revision, each one naming its **predicted failure** and the check for it before the change was made |
| **`ASSET-LOG.md`** | one row per generation kept or seriously considered, including every rejection, with two corrections left standing above the text they correct |
| **`TEST-REPORT.md`** | 110 checks with their observed values, the three defects they caught, and **what was not checked** |
| **`SOURCES.md`** | provenance for every file, in four categories, with the one open rights question flagged |
| **`FRICTIONAL.md`** | the honest log. What was wanted, what was decided, what went wrong, and for each entry what was mine and what was Claude's |
| **`PROMPTS.md`** | everything still to be generated, in the order to generate it, as text to paste — derived from the two documents above it, never a decision of its own |

---

## Layout

```
CONCEPT.md  CHARACTER-SHEET.md  STORYBOARD.md  CHANGE-BRIEF.md
ASSET-LOG.md  TEST-REPORT.md  SOURCES.md  FRICTIONAL.md  PROMPTS.md
README.md  run-game.bat

godot/
  project.godot              640x360, nearest texture filter, dark clear colour
  game/session.gd            level, dungeon drawing, traps, enemies, audio, state
  game/main.tscn
  features/player/player.gd  movement, dash, sword, the body as a parts list
  features/player/tuning.gd  every gameplay number, in one Resource
  ui/hud.gd                  bands, cards, progress, mute indicator
  levels/first_steps.json    geometry, traps, enemies, labels — data, not code
  assets/                    music loop, four sound effects, two placeholders
  assets/README.md           which of these is generated: one table
  tests/test_game.gd         96 checks
  tests/test_keyboard.gd     14 checks, through the real InputMap
  tests/capture_*.gd         real rendered-viewport captures, each asserting its state
  tests/route_driver.gd      the input route that completes the level

design/
  storyboard/                the hand-drawn sheet and its seven crops
  rejected/                  the Suno library screenshot — eight tracks, with prompts

evidence/
  screens/                   21 rendered frames + the character contact sheet
  mechanics-*.json           every suite run, kept
  keyboard-*.json

scripts/
  import_pose.py             a generated pose -> a checked 32x32 sprite
  synth_placeholder_sfx.py   the four placeholder effects, deterministically
  check_trap_visibility.py   pixel check: the spike is drawn only while lethal
  check_enemy_visibility.py  pixel check: enemies are drawn where they really are
  build_char_sheet.py        the contact sheet, from real frames
  build_level_map.py         the level as one wide image
```

`scripts/` also holds the Assignment 1 film pipeline — `build_coverage.py`,
`build_media_clips.py`, `build_source_snapshot.py`, `encode_captures.py`,
`mix_death_laugh.py`, `render_takes.py`, `record-build.cjs` — and
`godot/tests/capture_walkthrough.gd`. **Carried over, not used by this
assignment yet.** They are here because the Assignment 2 film will use them.

---

## Known state, stated plainly

- **No art has been generated.** The character and the dungeon are original
  vector drawing in code. `CHARACTER-SHEET.md` sections 3c and 4 hold the
  prompt and the pose spec that generation will run against.
- **The four sound effects are placeholders**, synthesised by arithmetic, and
  they do not satisfy the assignment's "generate sound" requirement. They exist
  so the masking check from `CONCEPT.md` revision 1.1 can be run at all, since
  it cannot be run against silence.
- **Four human checks are outstanding** — the loop seam, the masking check, the
  retry behaviour and a muted playthrough. `TEST-REPORT.md` section 6 lists
  them and none is done.
- **One open rights question**: the licence terms of Suno's purchased
  single-download pack have not been read. `SOURCES.md` section 3.
- **The suite does not assert what the player character looks like.** Every one
  of the 110 checks is behavioural. Two real art defects passed all of them.
  `TEST-REPORT.md` section 6 explains why a pixel-diff of the player is not the
  answer.

---

## Credit

Built on **Nik Bear Brown's `walker-jumpman` "First Steps"** starter, by way of
my own Assignment 1 extension
[`walker-jumpman-TiantongZhang`](https://github.com/TiantongZhang1/walker-jumpman-TiantongZhang)
at commit `d1a52cd`. The starter's eight movement values are unchanged and the
code says so where they are declared.

Written with **Claude Code** as a pair. Attribution is per-commit in
`Co-Authored-By` trailers, and per-decision in `FRICTIONAL.md`, which records
for every entry which parts were mine and which were Claude's.
