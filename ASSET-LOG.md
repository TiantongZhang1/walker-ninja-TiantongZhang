# ASSET-LOG.md

One row per generation I **kept or seriously considered**. Rejections stay in
here too, as thumbnails in `design/rejected/` — Assignment 2 says graders read
them, and the instructor's note says a screenshot of the prompt and result plus
one line of reasoning is a valid entry without spending a download.

**Download discipline.** Suno's free plan allows **7 downloads for the life of
the account and they never reset**. Listening and rejecting happens in the
browser. Only a finalist is downloaded. The counter below is maintained by hand
so I can see what is left.

| Suno downloads used | Remaining |
|---|---|
| **0** | **7** |

**Eight tracks generated on 2026-10-01 across two directions, every one of them
auditioned in the browser, and zero downloaded.** A third direction was rejected
from its prompt without being generated at all. Model: `v6-mini` for the four
usable tracks, `V6 PREVIEW` for four that came back capped at 1:00 behind an
upgrade button.

## Music

**Evidence:** `design/rejected/2026-10-01-suno-library.png` — a screenshot of
the Suno workspace listing all eight tracks with their prompts, durations and
model tags. The prompts below are transcribed from that listing, which is
Suno's own record of what was sent, not from what I meant to send.

**Reproducibility, stated honestly.** Suno exposes no seed, so these rows
reproduce the *request* and not the output: the same prompt will not return the
same audio. That is a limitation of the tool, not of the log, and it is why the
sound effects are planned for a model that does record a seed. The finalist will
be identified by its file hash once it is in the project.

**A constraint discovered by running it.** Four of the eight tracks came back
tagged `V6 PREVIEW` and capped at 1:00 with an "Upgrade for full song" button.
Those are not usable assets on the free tier regardless of how they sound, so
the real candidate pool is the four `v6-mini` tracks.

### Direction B — driving, 124 bpm — *accepted*

The prompt Claude wrote was used **verbatim**, four times, unchanged:

> `driving 124 bpm, pulsing bass with tight muted percussion, urgent and forward-moving, loop for a side-scrolling platformer, metal walkways and machinery, near-future industrial, no vocals, seamless loop`

Suno auto-titled all four **"Metal Walkways"** from the prompt.

| Asset ID | Model | Length | Usable? | Outcome |
|---|---|---|---|---|
| `MUS-B-01` | `v6-mini` | **1:54** | yes | **Finalist.** Not yet downloaded. |
| `MUS-B-02` | `v6-mini` | **1:42** | yes | **Finalist.** Not yet downloaded. |
| `MUS-B-03` | `V6 PREVIEW` | 1:00 | **no** — paywalled | unusable on the free tier |
| `MUS-B-04` | `V6 PREVIEW` | 1:00 | **no** — paywalled | unusable on the free tier |

Accepted as the direction on hearing it: *"很激情…能衬托出紧张感调动玩家肾上腺素"* —
passionate, and it sets off the tension. Judged against `CONCEPT.md` revision
1.1. **One of `MUS-B-01` / `MUS-B-02` still has to be chosen and downloaded**,
then cut at a bar boundary, checked across ≥3 repetitions for a seam, and
exported as OGG. None of that has happened; the slice still has no music.

### Direction A — sparse, 85 BPM — *rejected*

**The four prompts here were all reworded, and none of them is the prompt
Claude supplied.** Whether I edited them or Suno's prompt enhancement expanded
them is not something the screenshot settles, so it is **not asserted either
way**. What the library records is below, verbatim. Suno auto-titled all four
**"Cold Overhead Light"**.

| Asset ID | Model | Length | Prompt as the library records it |
|---|---|---|---|
| `MUS-A-01` | `v6-mini` | 3:08 | `Near-future industrial, seamless looping production with brushed-metal textures and cold overhead-light sheen, slow stately 85 BPM, instrumental, muted synth pads layered into a full dense bed with sparse plucked arpeggios` |
| `MUS-A-02` | `v6-mini` | 2:49 | `Instrumental near-future industrial game-loop music, driving urgent pulse with a seamless 85 BPM feel, dense muted synth pads and interlocking plucked arpeggios over brushed-metal percussion, cold overhead-light textures, spacious mix that loops cleanly` |
| `MUS-A-03` | `V6 PREVIEW` | 1:00 | `Near-future industrial ambient, muted synth pads and sparse plucked arpeggio layered into a full, dense arrangement, instrumental, laid-back 85 BPM pulse, brushed-metal textures and cold, spacious production with a seamless loop` |
| `MUS-A-04` | `V6 PREVIEW` | 1:00 | `Near-future industrial, muted synth pads and sparse plucked arpeggio gradually joined by brushed-metal percussion and low synth bass, instrumental, seamless loop with a restrained cold sheen, unhurried mid-tempo 85 BPM build from near-silence to a full arrangement` |

**All four rejected**, auditioned in the browser, none downloaded. Rejected
against revision 1.1's driving direction: this direction leaves the player
room, and the score is supposed to supply the pressure.

**Worth recording as a finding:** direction A got **four attempts with four
different wordings** — including `MUS-A-02`, which asked for a "driving urgent
pulse" at 85 BPM and so was already drifting toward direction B — and still
lost. Direction B won on the **first wording, used verbatim**. More prompt
iteration did not rescue a direction that was wrong for the game; the decision
that mattered was which feeling the score should carry, not how the sentence
was phrased.

### Direction C — cold industrial ambient — *never generated*

| Asset ID | Model | Outcome |
|---|---|---|
| `MUS-C-00` | **not generated** | **Rejected at the prompt stage.** *"第三个从文字描述上就提不起我的兴趣"* — the written description did not interest me. Cost: one unused daily credit, zero downloads. |

Recorded because deciding *not* to spend a generation is a judgement, and the
free daily credits do not carry over.

## Sound effects

| Asset ID | Model + version | Where run | Licence / terms | Prompt + settings | Outcome | Edits | Where used |
|---|---|---|---|---|---|---|---|
| `SFX-JUMP` | | | | | | | |
| `SFX-SLASH` | | | | | | | |
| `SFX-TRAP` | | | | | | | |
| `SFX-DEATH` | | | | | | | |

## Art

| Asset ID | Model + version | Where run | Licence / terms | Prompt + settings | Outcome | Edits | Where used |
|---|---|---|---|---|---|---|---|
| `CHAR-REF-01` | | | | | | | |

## Rejected, logged without downloading

| Date | Asset ID | Screenshot | Why rejected (against which pillar / sheet item) |
|---|---|---|---|
| 2026-10-01 | `MUS-A-01` … `MUS-A-04` | `design/rejected/2026-10-01-suno-library.png` (all eight tracks, prompts and model tags in one listing) | Too much room. Against CONCEPT revision 1.1's driving direction — the score supplies the pressure, and this direction does not. Four wordings tried; none rescued it. |
| 2026-10-01 | `MUS-B-03`, `MUS-B-04` | same screenshot | Right direction, but `V6 PREVIEW` capped them at 1:00 behind an upgrade button. Rejected on availability, not on sound. |
| 2026-10-01 | `MUS-C-00` | n/a — never generated | Rejected from the written prompt alone; it did not interest me. Recorded because *deciding not to spend a generation* is a judgement, and the daily free credits do not carry over. |
