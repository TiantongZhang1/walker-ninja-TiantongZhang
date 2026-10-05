# SOURCES.md — where everything in this repository came from

Every file is in exactly one of four categories: **starter code**, **original
work**, **generated**, or **placeholder**. If a row says "generated", it names
the model. If it says "placeholder", it says what replaces it and when.

Nothing here is traced from, prompted against, or derived from a named artist,
a copyrighted character, a brand, or an existing recording. **No credential,
API key or token is in this repository or its history.**

| | |
|---|---|
| Commit this document describes | `11fcc29a170536e783c6a2d84ccc192992c61e88` |
| Tracked files | 107 |

---

## 1. Starter code

**Nik Bear Brown's `walker-jumpman` — "First Steps".** The course starter. The
movement model is his: speed 160, jump −320, gravity 960, terminal velocity
480, coyote 6 ticks, jump buffer 6 ticks. Those eight numbers are
**deliberately unchanged** and `godot/features/player/tuning.gd` says so in a
comment at the point they are declared.

Reached here through **`walker-jumpman-TiantongZhang`** at commit `d1a52cd` —
my own Assignment 1 extension of that starter, at
<https://github.com/TiantongZhang1/walker-jumpman-TiantongZhang>. The double
jump, the air dash, the sword, the fork, the pop-up traps and the patrolling
enemies are from that project and are mine.

**Two files from Assignment 1 were deliberately not copied forward**: the death
reaction's meme cat image and the laugh taken from a personal video. Both are
third-party content with no documented permission. They were shipped in
Assignment 1 as a considered decision; they are **absent from this
repository's entire history**, not merely deleted from its tip, and are
represented by the placeholders in section 4.

---

## 2. Original work — mine, not generated

### All visual art in the running game

**Every pixel the game draws is original geometry written in GDScript.**
Nothing is imported, traced, or generated. The relevant code is
`godot/features/player/player.gd::_body_parts()` / `_draw()` and
`godot/game/session.gd::_draw()` / `_draw_alcove()` / `_draw_torch()` /
`_draw_spikes()` / `_draw_enemies()`.

| | |
|---|---|
| Character | deep navy plate, light-blue visor slit, purple scarf, back-slung blade, head / torso / two arms / two legs, directional rim light |
| Dungeon | stone wall, staggered mortar courses, blind arches, wall torches, platforms with a torchlit top edge |
| Hazards and enemies | spikes, slimes, flying horses |
| HUD | bands, cards, progress bar, labels |

The eight-colour palette is recorded with measured contrast ratios in
`CHARACTER-SHEET.md` sections 3, 3b and 3c.

**On the character's history.** The first sketch request named a character from
a commercial game. That was refused on rights grounds *before anything was
drawn*, and the design that exists was specified instead by colour and
silhouette — deep blue body, light-blue horizontal visor slit, purple scarf.
`CONCEPT.md` section "What this replaces, and what it credits" carries the
record.

### Design documents

`CONCEPT.md`, `CHARACTER-SHEET.md`, `CHANGE-BRIEF.md`, `STORYBOARD.md`,
`ASSET-LOG.md`, `FRICTIONAL.md`, this file, and `TEST-REPORT.md`. Written for
this project. Append-only: revisions are added, earlier text is not rewritten,
and corrections are left standing above the thing they correct.

### The storyboard sketches

`design/storyboard/sheet-2026-10-03.jpg` and the seven crops beside it.
**Hand-drawn in pen by me on 2026-10-03**, photographed, and cropped by script.
Not generated and not traced.

### The sound effects

`godot/assets/sfx-{jump,slash,trap,death}.ogg`. Synthesised by
`scripts/synth_placeholder_sfx.py` — closed-form waveforms plus one noise array
seeded at 727001. **Original, and also not generated**: see section 4, because
for the purposes of this assignment they are placeholders.

### Evidence

`evidence/screens/*.png` are **real rendered viewport captures** written by
`godot/tests/capture_game.gd`, `capture_character.gd` and `capture_enemies.gd`.
`evidence/screens/char-contact-sheet.png` is assembled from those frames by
`scripts/build_char_sheet.py`; the 18 × 28 collider rectangle on it is an
annotation drawn by that script, not something the game renders.
`evidence/*.json` are written by the test runs themselves.

---

## 3. Generated

### `godot/assets/music-loop.ogg`

| | |
|---|---|
| Model | **Suno `v6-mini`** |
| Asset ID in `ASSET-LOG.md` | `MUS-B-02`, identified by duration (101.614 s against the library's 1:42) |
| Run on | suno.com, in a browser, free tier |
| Seed | **none — Suno exposes no seed.** The prompt reproduces the request, not the output |
| Prompt, verbatim as Suno's library records it | `driving 124 bpm, pulsing bass with tight muted percussion, urgent and forward-moving, loop for a side-scrolling platformer, metal walkways and machinery, near-future industrial, no vocals, seamless loop` |
| Downloaded | via a **purchased single-download pack** |
| Source file | `Metal Walkways.mp3`, 2 625 278 bytes, SHA-256 `052baa0989785b7fa30126062ff7dd0bf07d6b5621b9a76c08234ae59ac06f8d` |
| In the project | 16 bars from 29.722 s, 30.9632 s long, 20 ms equal-power crossfade at the wrap, Vorbis q5, SHA-256 `ea52713afeef1cacdae6ee9b5fe9789ff266c57f7e2b9c6d6380b1e1a85db865` |
| Measured from the audio | 124.018 BPM, bar 1.9352 s, first downbeat 0.6938 s |

**My own edits:** tempo recovered from the audio rather than taken from the
prompt (spectral-flux onset envelope, autocorrelated, refined by a comb search
over period and phase); three candidate loops cut at bar boundaries and scored
for spectral continuity across the splice plus level match; the chosen one
crossfaded at the wrap. Method and numbers in `ASSET-LOG.md` under 2026-10-04.

> **⚠ OPEN RIGHTS ITEM — the one thing in this file that is not settled.**
> The licence terms of Suno's purchased single-download pack **have not been
> read**. They are *not* assumed to match the free tier's personal-use grant
> and they are *not* assumed to be broader. This must be checked against
> Suno's own terms page before submission, and the row above updated with what
> it actually says.
>
> What *is* settled: eight tracks were generated on 2026-10-01 across two
> directions, every one auditioned in the browser, and **zero** downloaded on
> the free tier. The free allowance was reported exhausted — Suno moved to
> seven lifetime downloads on 2026-09-03 and applied it retroactively, so
> downloads made on this account long before this course count against it.
> The paywall was **not circumvented** and nothing was screen-recorded.

### Nothing else is generated

**No art has been generated.** Not the character, not the dungeon, not the
enemies. `CHARACTER-SHEET.md` sections 3c and 4 carry the prompt skeleton and
the eleven-pose specification that generation will be run against; `REF-01`
does not exist yet.

**No sound effect has been generated.** See section 4.

---

## 4. Placeholders

Each is a documented stand-in that keeps the slice runnable and the test suite
honestly green. `godot/assets/README.md` lists them with a "Generated?" column.

| File | What it actually is | Replaced by | Why it exists |
|---|---|---|---|
| `godot/assets/death-laugh.ogg` | **3.42 s of silence**, `ffmpeg anullsrc` | a generated sound | Assignment 1's laugh was third-party with no documented permission. 3.42 s is deliberate: `test_game.gd`'s `enemy-death-reuses-the-reaction` reads the reaction's remaining time, so a stand-in of the same length keeps that assertion passing instead of weakening it |
| `godot/assets/death-laugh-cat.png` | a flat colour card reading PLACEHOLDER | generated art, or the reaction is cut | same rights problem |
| `godot/assets/sfx-jump.ogg` | 0.110 s, synthesised | a generated effect | see below |
| `godot/assets/sfx-slash.ogg` | 0.140 s, synthesised | a generated effect | " |
| `godot/assets/sfx-trap.ogg` | 0.260 s rising inharmonic metallic sweep, synthesised | a generated effect | " |
| `godot/assets/sfx-death.ogg` | 0.450 s, synthesised | a generated effect | " |

**The four effects are original but not generated, and they do not satisfy the
assignment's "generate sound" requirement.** They exist because `CONCEPT.md`
revision 1.1 predicted on 2026-10-01 that a 124 bpm bed with pulsing bass would
mask the trap's 15-frame warning, and that check is perceptual — it cannot be
automated **and it cannot be run against silence**. With them in place the
check runs now and runs again against the generated versions, comparable
instead of sequential. Replacement is file-for-file: no trigger, assertion,
level or balance changes.

| SHA-256 of the committed encodes | |
|---|---|
| `sfx-jump.ogg` | `fb8988a0ad17181289c1d4eaeeabdfcadece9bcf689cd26fbaa02fabf76ac4e0` |
| `sfx-slash.ogg` | `48133c472fd2120b1028c4c5597d73dd38739ad0ca8e5d627db07e84e3fa919c` |
| `sfx-trap.ogg` | `06d6218290628e4061fdbf77256f9814ff6232d6d121d4cf6c1663409399697f` |
| `sfx-death.ogg` | `37ba2eb0fe913792e1a902053cfeb11e65c6292ee03798c33d59f064dae46f73` |

Re-running the synthesis script reproduces the **WAVs** byte for byte. It does
**not** reproduce the OGGs byte for byte, because an Ogg page header carries a
stream serial number ffmpeg picks at random with no flag to pin it. The decoded
PCM of two runs matches byte for byte — checked, not assumed, with the commands
in the script's docstring. So the hashes above fingerprint one particular
encode rather than the sound.

---

## 5. Third-party screenshots of my own accounts

| File | What it is |
|---|---|
| `design/rejected/2026-10-01-suno-library.png` | a screenshot of **my own** Suno workspace, listing all eight generated tracks with their prompts, durations and model tags. Included as evidence because it is Suno's record of what was actually sent, which beats my summary of it — and it is why the log had to be corrected from "two generations" to eight |

No other screenshot of a third-party product is in this repository.

---

## 6. Fonts

**`ThemeDB.fallback_font`** — Godot's own built-in font, used for every string
the game draws. No font file is bundled, downloaded, or redistributed.

---

## 7. Tools

| Tool | Version | Licence | What it did here |
|---|---|---|---|
| **Godot Engine** | 4.7.2.stable.official.`ed1daf0bf` | MIT | the game, the test runner, the captures |
| **Python** | 3.12.10 | PSF | the build and check scripts |
| numpy | 2.5.3 | BSD-3 | tempo analysis, loop scoring, sound synthesis |
| scipy | 1.18.1 | BSD-3 | STFT, filtering, WAV I/O |
| Pillow | 10.4.0 | MIT-CMU | cropping the storyboard sheet, the contact sheet, the pixel checks |
| **ffmpeg** | 9.0.1-full_build (gyan.dev) | LGPL/GPL | decoding the mp3, encoding Vorbis |
| **Suno** | `v6-mini` | see the open item in section 3 | the music |
| **Claude (Anthropic)** | Claude Code | — | pair-programming throughout; attribution is per-commit in `Co-Authored-By` trailers and per-decision in `FRICTIONAL.md`, which records for each entry what was mine and what was Claude's |

---

## 8. What a reader should check first

1. **The open rights item in section 3** — the Suno download-pack terms. It is
   the only unresolved provenance question in the project.
2. `ASSET-LOG.md`, which has the full per-asset history including every
   rejection and two corrections that are left standing above the text they
   correct.
3. `godot/assets/README.md`, which is the shortest honest answer to "which of
   these did you actually generate".
