# FRICTIONAL — honest log of the design thinking

**walker-ninja-TiantongZhang · Tiantong Zhang · started 2026-09-30**

A dated log of the design as it happens: what I was trying to make the player
see or hear, what I asked the model for, what came back, and what I decided.
Written the same day, not reconstructed at the end — the instructor's note says
a week of small daily entries beats a last-night reconstruction, and he is
right that it is also easier.

> **"I" is me. "Claude" is Claude. "the model" is whichever generative model
> produced the asset.** Assignment 2 scores those three apart, so they are
> never blended. Claude writes code, prompts and plans and organises these
> notes; it does not generate images or audio, and it does not write my
> judgement for me.

---

## 2026-09-30 — setting up, and the one thing that had to happen first

**Wanted:** to start generating music tonight, because the free daily credits
do not carry over and there are only four days left.

**What stopped me:** the rubric gives a point for the design being committed
**before** the first generation, and the whole provenance claim depends on that
ordering being checkable. Generating first and writing the concept after would
have cost that point in a way nothing later could repair — git timestamps show
the order.

**Decided:** commit `CONCEPT.md` v1 first, then generate. The concept does not
have to be final; the assignment says to retain the original and append
revisions, so v1 is a real specification rather than a placeholder, and the
three decisions that are genuinely mine are marked `[TZ DECIDE]` in it rather
than guessed at.

**Also decided: continue Assignment 1's game rather than start a new one.**
Four days is not enough to design a new game *and* generate for it. The
cyber-ninja build already has tested movement, a level, enemies and a
death/retry loop, which leaves the four days for design and generation — which
is what this assignment is actually about.

**One thing I get for free by doing it this way:** Assignment 1's death
reaction used a meme cat image and a laugh with no documented permission.
Assignment 2 requires generated audio anyway, so those two files were not
copied into this repository at all. They are replaced by documented
placeholders — a flat colour card and 3.42 s of silence — and will be replaced
again by generated assets. The placeholder audio is exactly 3.42 s because
`test_game.gd` asserts the reaction's remaining time, so the suite stays green
without weakening an assertion.

**Human / Claude / model:** I chose to continue the A1 game and to accept the
"design first, generate second" ordering. Claude set up the repository, read the
shipped game to draft `CONCEPT.md` from measured values rather than invention,
made the placeholders, and verified 79 + 14 checks still pass. No generative
model has been used yet.

**Still unresolved:** the three `[TZ DECIDE]` items — the art style, what the
music should make the player feel, and what the music does during the 0.55 s
retry. The first Suno prompt is blocked on the second one.

**Traceability:** commit `766cf15`, `CONCEPT.md` v1, `godot/assets/README.md`.

---

## 2026-10-01 — the music direction, and a contradiction it exposed in my own concept

**Wanted:** a music direction concrete enough to prompt with. Claude gave me
three directions, written as full prompts so I could hear the difference rather
than argue about adjectives: sparse and patient, driving and urgent, or cold
industrial ambient.

**Decided — driving.** My words:

> 我选的第二个，因为首先很激情，而且能衬托出紧张感调动玩家肾上腺素

*I chose the second one, because first it is passionate, and it can set off the
tension and get the player's adrenaline going.*

**What that exposed.** `CONCEPT.md` v1's audio direction said *"the game is
quiet and the hazards are sudden"*, and made the sound's whole job letting a
15-frame warning feel like enough time. **That line was Claude's draft, not my
decision** — Claude inferred "quiet" from the shipped game, which has almost no
audio at all, so it described an absence and called it an intention. My
intention is the opposite. The draft is what was wrong, and
`CONCEPT.md` revision 1.1 records that rather than quietly editing the
sentence.

**What it costs, which I am accepting on purpose.** Pillar 2 needs the trap's
rising sound to be *heard* at the trigger, and a 124 bpm bed with pulsing bass
and tight percussion competes for exactly that. So:

- `SFX-TRAP` now has to be designed **against** the music — a rising metallic
  sweep, distinguishable by moving pitch rather than by volume, because the
  music already owns the low end and the percussive transients. Judging it
  alone in Audacity is not a test of it.
- It becomes a predicted failure case for `CHANGE-BRIEF.md`: *the 15-frame
  warning is masked by the music, so the hazard reads as unfair with sound on
  although it is fair with sound off.* Checked by a human playtest of the trap
  section at full music level, because masking is perceptual and no automated
  count can see it.
- The muted-play requirement limits the damage either way: the trap is already
  fair on visuals alone (15 visible frames, 96 px of run-up), so the worst case
  is "the sound added nothing", not "the game became unfair".

**Human / Claude / model:** I chose the direction and the reason. Claude wrote
the three candidate prompts, spotted that my choice contradicted the audio
direction it had itself drafted, said so instead of letting both sentences
stand, and worked out what the choice does to `SFX-TRAP`. **No generative model
has been used yet** — see the open question below.

**Still unresolved:** whether I pick the art style before or after seeing the
first generated character; and what the music does during the 0.55 s retry,
which cannot be judged until the loop is actually playing in the game.

**Traceability:** `CONCEPT.md` revision 1.1, commit to follow.
