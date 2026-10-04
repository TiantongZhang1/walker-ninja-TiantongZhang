# CHANGE-BRIEF.md — what Assignment 2 changes in the slice

Append-only, the same discipline `CONCEPT.md` and Assignment 1's brief use:
later revisions are added below, earlier ones are never rewritten.

---

# Revision 2.0.0 — 2026-10-03 — the plan, written before any art or sound exists

**Where this sits in the order.** `CHARACTER-SHEET.md` was written earlier
today and is the specification this brief implements. The music was generated
on 2026-10-01, *before* either document existed; the art and the sound effects
have not been generated at all yet, so for everything except the music this
brief comes first. That split is recorded as it happened in `FRICTIONAL.md`.

## 0. What is **not** changing

**Every gameplay number is frozen.** `tuning.gd` is untouched: speed 160,
jump −320, gravity 960, coyote 6, buffer 6, air jumps 1, air dashes 1, dash
speed 400, dash 10 ticks, attack 16 ticks (4 windup / 9 active / 3 recovery),
reach 30. Level geometry, enemy patrols and trap timings are untouched.

This is deliberate and it is the point of the exercise. The assignment compares
the slice before and after its assets. If the tuning moved at the same time, the
comparison would measure two things at once and prove neither. **If the new art
makes the game feel different, that is the art doing its job — not a number.**

Also unchanged: the collider (18 × 28 at (0, −14)), the collision layers, and
the swing hitbox geometry.

## 1. The changes

### C1 — Texture filter set to nearest

**What.** Add `rendering/textures/canvas_textures/default_texture_filter=0` to
`project.godot`. There is no `[rendering]` texture entry today
(`godot/project.godot`), so the project is on the linear default.

**Why.** `CONCEPT.md` revision 1.2 commits to pixel art, and the assignment
names this setting specifically. Without it every generated frame is blurred by
bilinear filtering and the 1 px outline of `CHARACTER-SHEET.md` section 3 turns
into a 3 px smear — which would destroy the one colour that carries the
character against the cream sky.

**Predicted failure.** The project renders 640 × 360 logical with
`canvas_items` stretch into a 1280 × 720 window — an exact 2×, which is safe.
The film renders at 3840 × 2160, an exact 6×, also safe. But any **non-integer**
scale (a resized window, a 1366 × 768 laptop) puts nearest-neighbour sampling on
fractional boundaries and some sprite rows become 2 px tall while their
neighbours stay 1 px. The character then visibly shimmers while walking.

**Check.** Screenshot the same idle frame at 1280 × 720 and at one deliberately
awkward window size, and compare the helm's pixel rows. If the awkward size
shimmers, that is recorded as a known limitation of windowed play rather than
fixed by turning filtering back on — the fix would cost the whole art direction.

### C2 — The player body becomes a texture; the sword stays code-drawn

**What.** `player.gd:_draw()` keeps its structure. The body-and-scarf block
(`player.gd:300-336`) is replaced by a single texture draw selected from the
state table in `CHARACTER-SHEET.md` section 5. The sheathed-blade block and the
swung-blade block are **left exactly as they are**.

**Why.** `CHARACTER-SHEET.md` section 2 has the argument in full: the swung
blade is built from `ATTACK_PIVOT`, `attack_angle()` and `tuning.attack_reach`,
and so is the kill hitbox. Baking the blade into a static frame would let the
picture and the hitbox drift apart silently the next time anyone touches the
tuning.

**Predicted failure, concrete.** `_mrect`/`_mpoly` mirror the character by
negating x (`player.gd:239-251`). `draw_texture_rect` has no flip argument, so a
naive port draws the sprite facing right while the sword still mirrors — a
character swinging backwards. The fix is `draw_set_transform(Vector2.ZERO, 0.0,
Vector2(facing, 1.0))` around the texture draw only, reset before the sword.

**Check.** Run left, swing, screenshot. The blade must leave from the shoulder
the character is facing. This is an eyes-on check because it is a visual
contradiction, not a numeric one.

**Second predicted failure.** The sprite's anchor is (20, 30) in a 32 × 32 cell.
Get that wrong and the character floats above the floor or sinks into it, while
every collision test still passes — because the collider has not moved. A green
suite would say nothing.

**Check.** Stand idle on a platform, zoom the screenshot, confirm the lowest
opaque sprite row is the platform's top row. Then flip through all eight poses
in place and confirm the feet do not move vertically
(`CHARACTER-SHEET.md` section 6, item 5).

### C3 — A death pose, which does not exist today

**What.** On `State.DYING`, draw pose P8 instead of whatever frame the player
was on.

**Why.** `session.gd:477-492` sets `player.enabled = false` on death and the
sprite simply freezes. For 0.55 s the player looks at a character mid-stride,
hanging in the air, with no acknowledgement that anything happened. Pillar 1 of
`CONCEPT.md` is "every failure teaches"; a frozen frame teaches nothing.

**Predicted failure.** The player is frozen but `_draw()` still runs, and
`is_on_floor()` on a disabled body is whatever it was last tick. Keying P8 off
movement state instead of off `session.state` would give an inconsistent pose
depending on *how* the player died. P8 must be keyed off the session state, and
it must take priority over every other row in the table.

**Check.** Die three ways — spikes, a fall, an enemy — and confirm the same pose
in all three. The existing `test_game.gd` already drives all three deaths.

### C4 — Music

**What.** One `AudioStreamPlayer` on a `Music` bus, looping, started when
`State.PLAYING` begins. The loop is cut from `MUS-B-01` or `MUS-B-02`
(`ASSET-LOG.md`), neither of which has been downloaded yet — 0 of 7 lifetime
downloads are spent.

**Why.** `CONCEPT.md` revision 1.1: driving, 124 bpm, the score supplies the
pressure.

**Predicted failure — the one already written down.** Revision 1.1 predicted it
in advance and it is restated here because this is the brief that has to check
it: *the trap's 15-frame warning is masked by the music, so the hazard reads as
unfair with sound on even though it is fair with sound off.* A 124 bpm bed with
pulsing bass and tight percussion competes for exactly the attention the warning
needs.

**Check.** A human playtest of the trap section at full music level, listening
for the warning specifically. Automated checks cannot test masking — it is
perceptual. If it fails, `SFX-TRAP` is redesigned as a rising sweep (pitch
motion, which percussion does not have) before the music is touched, because the
music direction is a decision and the trap sound is an implementation of it.

**Second predicted failure.** A loop cut anywhere but a bar boundary clicks
once per repetition. Heard once it sounds like a glitch; heard twenty times it
is the thing the player remembers.

**Check.** Play the exported OGG three times back to back and listen at the
seam before it goes anywhere near the project.

**Third predicted failure.** `session.gd:456-465` pauses `laugh` on focus loss
and on pause. A second stream added without the same handling keeps playing
after the window loses focus.

**Check.** Alt-tab mid-level. Silence, both streams.

### C5 — Sound effects

Four, matched to events that already exist in the code:

| ID | Event | Where it fires |
|---|---|---|
| `SFX-JUMP` | jump and air jump | `player.gd:221-233` — both branches |
| `SFX-SLASH` | swing starts | the tick `attack_phase()` goes 0 → 1 |
| `SFX-TRAP` | trap trigger, the 15-frame warning | the trap's rise, not its contact |
| `SFX-DEATH` | fatal contact | `session.gd:477` |

**Why these four and not more.** They are the four moments the player's hands
are already committed to. A sound on an event the player did not cause teaches
nothing.

**Predicted failure.** `SFX-TRAP` has to fire the tick the player crosses
`trigger_x`, which is where the 15-tick rise starts (`TRAP_RISE_TICKS = 15`,
`session.gd:29`). Hanging it off the damage contact instead would make it a
death sound, arriving after the information is useless — and it would *still
pass* a test that only asserted "a sound played when the trap killed me".

**Check.** An assertion on the tick index: the sound's start tick equals the
tick `trap_risen[i]` leaves 0, and is at least 15 ticks before any contact. The
geometry gives the player room for it — trap 0 triggers at x = 1064 and its
spike starts at x = 1160, so 96 px of run-up, 87 px to the player's leading edge
(`levels/first_steps.json:27`, and `test_game.gd:547` already computes exactly
that distance).

**Generator requirement.** `CHARACTER-SHEET.md` section 8 and `ASSET-LOG.md`
both say it: these go on a tool that records a seed, so the log can reproduce
the output and not only the request. That is a direct consequence of Suno being
unable to, which is logged there.

### C6 — Mute

**What.** A new `mute` action (key `M` is taken by `menu` in
`session.gd:105` — so `KEY_0` or `KEY_N`), toggling the master bus, with the
state shown on the HUD.

**Why.** The assignment requires the slice to stay understandable with all sound
muted, and that is not a claim to make without being able to test it in one
keypress.

**Predicted failure.** Muting by setting stream volumes individually leaves any
stream added later audible. It has to be the bus.

**Check.** Mute, then play a full run including a death and the trap. Nothing
audible, and the run is still completable — the trap is already fair on visuals
alone (15 frames of visible rise, 96 px of run-up, section C5), so a failure here would mean
the art changes broke the visual warning, which is worth knowing.

### C7 — The placeholder death assets are replaced

**What.** `godot/assets/death-laugh.ogg` (3.42 s of silence) and
`death-laugh-cat.png` (a flat PLACEHOLDER card) are replaced by generated
assets, or the reaction is cut.

**Why.** `godot/assets/README.md` records why they are placeholders: Assignment
1's meme cat and laugh had no documented permission and were deliberately not
copied into this repository.

**Predicted failure, and it is certain.** `test_game.gd`'s
`enemy-death-reuses-the-reaction` asserts the reaction's remaining time, and the
placeholder is 3.42 s **on purpose** to keep that assertion honest. Any
generated sound of a different length breaks it.

**The honest fix, stated in advance so it is not improvised later.** The
assertion is rewritten to read the stream's own length
(`laugh.stream.get_length()`, which `session.gd:97` already does) rather than a
literal 3.42. It is **not** deleted, and it is **not** loosened to a range. The
assignment forbids removing a failing assertion to get a green report, and the
README already commits to that in writing.

## 2. Order of work, and why

1. REF-01, then the eight required poses — everything else waits on them.
2. C1, then C2 — the filter has to be right before any pose can be judged in
   the game.
3. C3 — needs P8.
4. C4 and C6 together — the mute check is how the music gets judged.
5. C5, then C7 — the trap sound is the one with a real risk attached, and C7's
   test rewrite is cleanest once the real sound lengths are known.

## 3. The risks worth naming now

| Risk | Consequence | Where it is handled |
|---|---|---|
| A generated pose loses the scarf | The character is invisible on platforms (1.12:1) | `CHARACTER-SHEET.md` section 3; silhouette check first |
| The music masks the trap warning | A fair hazard reads as unfair | C4, human playtest |
| Download budget | 7 Suno downloads for the life of the account, 0 spent | one download, chosen after a browser audition |
| Time | 4 days to 2026-10-07 | the optional poses P9–P11 are the slack, and are dropped first |
