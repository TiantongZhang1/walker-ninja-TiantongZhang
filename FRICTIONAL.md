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
