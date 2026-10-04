# STORYBOARD.md — six panels across the slice

**Written 2026-10-03, before any art or sound effect has been generated.**

## What these panels are, and what they are not

**The level already exists.** It was built for Assignment 1 and it already
divides itself into six signposted sections — the label text below is read out
of `godot/levels/first_steps.json`, not invented for this document:

| | label in the level | label drawn at x | section runs to |
|---|---|---|---|
| 01 | `GET MOVING` | 33 | 474 |
| 02 | `MIND THE GAP` | 474 | 862 |
| 03 | `PICK A ROAD` | 862 | 1544 |
| 04 | `SOMETHING PATROLS` | 1544 | 2100 |
| 05 | `CONTESTED LANDINGS` | 2100 | 2700 |
| 06 | `LAST STAND` | 2700 | 3072 (level width) |

The x values are the label draw positions in the level file; a section runs
from its own label to the next one.

So the panels are **retrospective about gameplay and forward-looking about
appearance**. What happens in each one is already decided and testable; what it
*looks and sounds like* is the thing this assignment changes, and that is the
column every panel below actually commits to. Labelling it the other way round —
pretending the storyboard designed the level — would be the easiest sentence to
write and the only dishonest one in the file.

A storyboard for a level that already runs is still worth drawing, for one
reason: it is the only artefact that puts **pose, sound and background in the
same frame**. The character sheet specifies poses in isolation and the change
brief specifies wiring in isolation. Neither of them can catch "the scarf reads
fine on the test background and disappears here".

## The hand-drawn sketches

Six, one per panel, drawn by hand and photographed into
`design/storyboard/panel-01.jpg` … `panel-06.jpg`.

**None of them exists yet.** Each panel below names its file; the panel is not
finished until that file is there.

What a sketch has to show, and it is a low bar on purpose — the point is the
composition, not the draughtsmanship:

- the character, at roughly its real size relative to the platform
- which pose from `CHARACTER-SHEET.md` section 5 it is in
- where the camera edge is
- the one thing in the frame the player is supposed to be looking at

---

## Panel 01 — `GET MOVING`

| | |
|---|---|
| Sketch | `design/storyboard/panel-01.jpg` — **not yet drawn** |
| Where | x 0 – 474, the long opening platform; spawn is (64, 320) |
| In frame | the character, the 48 × 16 step at x 160, the single fixed spike at x 320, the label `01 / GET MOVING` and `Read the landing. Then jump.` |
| Poses | **P1 Idle**, then **P2 Run**, then **P3 Rising** |
| Sound | music loop enters here (`MUS-B-01` or `-02`); `SFX-JUMP` on the first jump |
| Pillar | 4 — readable at 18 × 28. This is the first frame anyone sees the character in. |

**What the panel has to prove.** That the character reads at all. The opening
platform is dark slate and the sky above it is cream, so this single frame
contains both of the backgrounds from `CHARACTER-SHEET.md` section 3 — body at
1.12:1 against the platform, visor at 1.32:1 against the sky. **If the scarf is
not doing its job, this is where it shows**, before any complication.

---

## Panel 02 — `MIND THE GAP`

| | |
|---|---|
| Sketch | `design/storyboard/panel-02.jpg` — **not yet drawn** |
| Where | x 474 – 862; gaps at 448–512 and 736–784, a raised 48 × 32 block at x 576 |
| In frame | the character airborne over a gap, both platform edges, the label `02 / MIND THE GAP` |
| Poses | **P3 Rising** into **P4 Falling** |
| Sound | music; `SFX-JUMP` |
| Pillar | 1 — every failure teaches. A missed gap is the cheapest lesson in the level. |

**What the panel has to prove.** That rising and falling are distinguishable
*against the sky*, where the visor contributes almost nothing (1.32:1) and only
the `shade` outline and the scarf are carrying the silhouette. The scarf's
direction is the tell: below-and-behind rising, above-and-behind falling.

---

## Panel 03 — `PICK A ROAD`

| | |
|---|---|
| Sketch | `design/storyboard/panel-03.jpg` — **not yet drawn** |
| Where | x 862 – 1544, the fork |
| In frame | **both roads at once** — the high planks at y 224 and y 200, the low floor at y 320 with three pop-up traps (spikes at x 1160, 1296, 1432), the slime patrolling the high road between x 1356 and 1424, and both labels: `HIGH ROAD - GUARDED` and `LOW ROAD - IT BITES` |
| Poses | **P1 Idle** at the decision point; the branch is not drawn |
| Sound | music only — deliberately |
| Pillar | 3 — choose the risk |

**What the panel has to prove.** That the choice is legible *before* it is made.
This is the one panel where the character is standing still and the composition
has to carry everything, so it is the panel most likely to fail on background
clarity rather than on the character.

**The one thing the player should be looking at** is not the character — it is
the two labels. That is worth drawing explicitly, because it is the only panel
in the slice where that is true.

---

## Panel 04 — `SOMETHING PATROLS`

| | |
|---|---|
| Sketch | `design/storyboard/panel-04.jpg` — **not yet drawn** |
| Where | x 1544 – 2100 |
| In frame | the character mid-swing, a slime patrolling x 1580 – 1690, a flying horse at y 268 patrolling x 1700 – 1820, the label `One slash is enough. Touching one is not.` |
| Poses | **P6 Attack windup** (4 ticks) and **P7 Attack live** (9 ticks) |
| Sound | music; `SFX-SLASH` on the transition into windup |
| Pillar | 1 and 3 |

**What the panel has to prove, and it is the hardest one.** The sword is **not
generated** — `CHANGE-BRIEF.md` C2 keeps it code-drawn so it cannot drift from
the kill hitbox. So the sketch must show the generated *body* committing to a
swing with a code-drawn blade over it, and the two must look like one action.

The live window is 9 ticks — 150 ms. If windup and live are not distinguishable
as still images, the player cannot learn the timing, and the only thing left
teaching it is `SFX-SLASH`. That is a real dependency between an art decision
and a sound decision, and this panel is where it is visible.

---

## Panel 05 — `CONTESTED LANDINGS`

| | |
|---|---|
| Sketch | `design/storyboard/panel-05.jpg` — **not yet drawn** |
| Where | x 2100 – 2700, four 128 px platforms with 64 px gaps |
| In frame | the character dashing across a gap, a horse holding the gap at y 268, a slime on the far platform, the label `The horses hold the gaps.` |
| Poses | **P5 Dash** (10 ticks, 167 ms) |
| Sound | music; this is the loudest, busiest stretch |
| Pillar | 2 and 3 |

**What the panel has to prove.** That the dash reads as a *committed*,
horizontal, non-invincible move. The dash is the only pose with no vertical
lean and a fully extended scarf, and it is the one the player spends once per
airborne period — so it has to look like a decision, not like fast running.

---

## Panel 06 — `LAST STAND`, and the trap

| | |
|---|---|
| Sketch | `design/storyboard/panel-06.jpg` — **not yet drawn** |
| Where | x 2700 – 3072; trap triggers at x 2704, spike at x 2800; finish at (3030, 264) |
| In frame | **the moment of the trap**: the character past the trigger, the spike part-way through its 15-tick rise, the finish visible beyond it |
| Poses | **P2 Run**, and the alternate **P8 Death** |
| Sound | `SFX-TRAP` **on the trigger crossing, not on the contact**; `SFX-DEATH` only if it lands |
| Pillar | 2 — the floor is not safe |

**What the panel has to prove, and it is the whole argument of the assignment.**
The player has 96 px of run-up between the trigger at 2704 and the spike at 2800
— 87 px to their leading edge — and 15 ticks of visible rise. The hazard is
already fair on visuals alone; that was established in Assignment 1 and it is
not being changed.

So the sound here cannot make the game *more* fair. It can only make the warning
**arrive sooner than the eye finds it**, or it can be masked by a 124 bpm bed
with pulsing bass and add nothing. `CONCEPT.md` revision 1.1 predicted the
masking in advance and `CHANGE-BRIEF.md` C4 carries the check: a human playtest
of this exact section at full music level.

**This panel is drawn twice** — once at the trigger crossing and once at P8, the
death pose, because P8 does not exist in the build today (`CHANGE-BRIEF.md` C3)
and this is the only place in the storyboard where it can be specified against a
real background.

---

## What the six panels cover between them

| | P1 | P2 | P3 | P4 | P5 | P6 | P7 | P8 |
|---|---|---|---|---|---|---|---|---|
| 01 | ● | ● | ● | | | | | |
| 02 | | | ● | ● | | | | |
| 03 | ● | | | | | | | |
| 04 | | | | | | ● | ● | |
| 05 | | | | | ● | | | |
| 06 | | ● | | | | | | ● |

All eight required poses appear in at least one panel. The three optional poses
(P9 air jump, P10 attack recovery, P11 celebrate) appear in none, which is
consistent with them being the slack in `CHANGE-BRIEF.md` section 2 — if they
are dropped, no panel loses anything.

Both backgrounds appear: cream sky in every panel, dark slate platform in every
panel, and panel 03 is the only one showing the high planks and the low floor
simultaneously.

## Open

- **All six sketches.** None drawn.
- Panels 01 and 06 are the two that must be drawn first: 01 is the contrast
  test and 06 is the fairness argument. If time runs out, those two plus 04 are
  the set that still proves something.
