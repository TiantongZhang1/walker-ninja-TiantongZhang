# CONCEPT.md — the game in one page

**walker-ninja-TiantongZhang · Tiantong Zhang · v1, 2026-09-30**

> **Version 1, committed before the first generation.** Later revisions are
> appended; this version is not rewritten. Assignment 2 §1.
>
> **Drafted from the game that already exists.** This is not a new idea — it is
> the Assignment 1 build (`walker-jumpman-TiantongZhang`, commit `d1a52cd`),
> whose design decisions were already made and already defensible. Claude wrote
> this page by reading the shipped game: the palette values, the tuning numbers
> and the level data below are measured from the source, not invented. The
> places that need **my** decision rather than a reading of the code are marked
> **`[TZ DECIDE]`**.

---

## The game in two sentences

You are a cyber-ninja crossing a narrow industrial course where the floor
itself is the threat: spikes rise out of it without warning, slimes crawl its
platforms, and horses patrol the gaps you have to jump.

You run right, choose between a guarded high road and a trapped low road, and
spend two one-shot abilities — a second jump and an air dash — on the crossings
that need them, knowing that every mistake kills you instantly and puts you
back at the start of the attempt in just over half a second.

## Core loop

**The action you repeat:** approach a gap or a hazard, read it, and commit to a
crossing.

**What you decide each time:** which of the three ways across to spend. A plain
jump covers 106 px. A jump plus the air jump covers 182. Add the air dash and
it is 249. Both extras refill **only** when you touch the floor, so the
decision is not "can I make it" but "do I still need them in ten seconds".

**What you risk:** the whole attempt. There are no lives, no checkpoints and no
health. One contact with a spike, a slime or a flying horse ends the run, and
the level resets to the spawn 0.55 s later. The run is 3072 px long; dying at
x=2800 costs you everything before it.

## Design pillars

Four experiences every asset has to serve. Each one already has a decision in
the shipped build, which is why they are pillars and not slogans.

### 1. Every failure teaches

You never die without being told what killed you. The game names one of three
causes on screen — *Missed the landing*, *Watch the spikes*, *It got you* — and
all three run through a single code path, so the freeze, the reaction and the
retry are identical and only the sentence changes.

**Asset choice that honors it:** the three death events get **three
distinguishable sounds**, not one generic hit. A player with the screen covered
should still know which mistake they made.

### 2. The floor is not safe

The signature hazard rises out of ground you already walked on. Each spike is
buried until you cross a trigger 96 px earlier, then takes exactly **15 frames**
to come up. Fifteen frames is the entire fairness contract, and the spike is
lethal only where it is drawn — that was a real defect once, found by playing.

**Asset choice that honors it:** the trap needs **its own rising sound**,
starting on the trigger and not on the kill, so the warning is audible as well
as visible. Art-wise the spike must read as *coming out of* the floor, so the
floor tile and the spike have to be designed together.

### 3. Choose the risk

The level forks. The high road is an 8 px plank 96 px up whose underside blocks
a plain double jump, so reaching it costs jump + air jump + dash — and getting
off it costs the dash a second time. What it buys is skipping three spike traps.
The low road is cheaper and lined with them.

**Asset choice that honors it:** the two roads must be **visually distinct at a
glance** from the fork platform — different surface material, not just
different height — so the choice is readable before it is committed to.

### 4. Readable at 18 by 28 pixels

The whole character is an 18 × 28 collider on a 640 × 360 canvas. Detail that
disappears at that size is not detail. The silhouette carries everything, which
is why the Assignment 1 character ended up with a blade across its back: a
34 px diagonal reads at that scale where a narrower head does not.

**Asset choice that honors it:** every generated frame is judged **scaled to
on-screen size first**, and against a solid-black silhouette, before anyone
looks at its detail.

## Art direction

**The constraint, measured from the build.** The character's existing palette is
deep navy plate `#1f3a6e` with `#16233d` shading, a light-blue visor slit
`#7fe3ff` with a `#d8f7ff` glint, a purple scarf `#8a5cf0` → `#6a3fbf`, and a
steel blade `#4a5468` / `#9aa7bd`. The environment is cream `#f6f3ec` sky,
`#e4e8e3` hills and dark slate platforms. **The generated character must stay
readable against cream and against slate**, which is the real test — a dark
character on a cream sky is high contrast, but the same character standing on a
dark platform is not.

**`[TZ DECIDE]` — the style.** The shipped art is flat vector shapes with hard
edges and no texture, because it is drawn in code. Generated art can be
something else, and this is the one decision that changes every prompt from here
on. Three options, pick one and delete the others:

- **(a) Keep the flat look.** Prompt for flat vector-style sprite art, hard
  edges, no gradients. Lowest risk: the generated frames will sit beside the
  existing level art without a style clash, and the comparison in the film is
  clean. Least visually ambitious.
- **(b) Pixel art.** Prompt for a small pixel sprite, limited palette, 1 px
  outline. Honest fit for a 640 × 360 canvas, and the import filter note in the
  assignment exists for exactly this. Needs the texture filter set to nearest
  or the frames blur.
- **(c) Painted / textured.** More atmosphere, but at 18 × 28 the texture is
  mush, and it will clash with the flat level art unless the environment is
  regenerated too — which is more generation than four days has room for.

**Reference notes in words** (materials, lighting, era, mood — no artist
names, per the assignment's rights rules): brushed metal and matte fabric;
flat overhead light with no visible source; near-future industrial, not
cyberpunk-neon; quiet and deliberate rather than frantic.

## Audio direction

**What it should make the player feel.** The game is quiet and the hazards are
sudden. The sound's job is to make a 15-frame warning feel like enough time —
the spike should be *heard* starting before it is seen finishing.

**`[TZ DECIDE]` — the music's feel.** One or two sentences in your own words:
what should the loop make you feel while you are crossing? Something to react
against (tense, driving) or something to be calm inside (sparse, patient)?
This decides every Suno prompt.

**Music behavior, which the build already determines:**

| Moment | What the music does | Why |
|---|---|---|
| Playing | the loop runs | — |
| Paused (Escape, or the window losing focus) | pauses with the game | the game already freezes everything on focus loss; music that kept playing would be the one thing that did not |
| Death → the 0.55 s retry | **`[TZ DECIDE]`**: duck, or keep running? | 0.55 s is too short to stop and restart cleanly; ducking is probably the only option that does not sound broken |
| Completion | stops, leaving the results card quiet | the run is over; silence marks it |

**The four sound events** come straight from the core loop and are fixed by
pillar 1 and pillar 2:

| ID | Event | Why this one |
|---|---|---|
| `SFX-JUMP` | leaving the ground | the verb the whole game is built on |
| `SFX-SLASH` | the sword's live window opening | the only thing you do to the world |
| `SFX-TRAP` | a trap's trigger crossed, i.e. the rise **starting** | pillar 2: the warning must be audible |
| `SFX-DEATH` | the attempt ending | pillar 1, and the only one of the four that is a failure |

The three death reasons sharing one sound is a compromise I am making on
purpose for four days; pillar 1 wants three. **Recorded as a known limitation
rather than quietly dropped.**

---

## What this replaces, and what it credits

Started from **`walker-jumpman-TiantongZhang`** at commit `d1a52cd`, which is
itself an extension of **Nik Bear Brown's `walker-jumpman` "First Steps"**
starter. Both are credited in `SOURCES.md`.

Two files did **not** come across: the Assignment 1 death reaction's cat image
and laugh, which are third-party content with no documented permission. They
are replaced in this project by documented placeholders
(`godot/assets/death-laugh-*`, a flat colour card and 3.42 s of silence) so the
test suite stays green, and they will be replaced again by **generated** assets,
which is what Assignment 2 requires anyway. This project therefore carries no
undocumented-rights asset at any point in its history.
