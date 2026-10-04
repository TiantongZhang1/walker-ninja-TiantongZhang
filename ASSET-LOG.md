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

> **CORRECTION, 2026-10-04 — the counter above is wrong, and it is left standing
> so the mistake is visible.** Suno refuses to download at all: it reports the
> download allowance as already used up, although no track has been downloaded
> for this project. Suno changed its free plan on **2026-09-03** to seven
> downloads for the life of the account, **applied retroactively** — so any
> download ever made on this account, from before this course existed, is
> counted against the seven. "0 used" was never a number I verified; it was an
> assumption that the account started clean on the day the project did.
>
> **Consequence:** `MUS-B-01` and `MUS-B-02` cannot be brought into the project.
> Eight generations and a decided music direction are still on the record and
> still count as work; what is lost is the audio file. The music is regenerated
> on a tool that can actually hand over the file — see the correction entry
> below and `FRICTIONAL.md` 2026-10-04.

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

### 2026-10-04 — the file is in the project

**How.** A single-download pack was purchased. The free-tier wall described in
the correction above was not circumvented and nothing was screen-recorded; the
download was paid for. **The exact licence terms of that pack have not been
read yet** and are an open item for `SOURCES.md` — they are not assumed to be
the same as the free tier's personal-use grant, and they are not assumed to be
broader either.

**Which track.** `MUS-B-02`, identified by duration: the downloaded file is
101.614 s (1:41.6), and the library screenshot lists `MUS-B-02` at 1:42.

| | |
|---|---|
| Source file | `Metal Walkways.mp3`, 2 625 278 bytes, mp3 48 kHz stereo ~207 kbps |
| Source SHA-256 | `052baa0989785b7fa30126062ff7dd0bf07d6b5621b9a76c08234ae59ac06f8d` |
| Downloads used | **1** (paid pack; the free lifetime 7 were already spent before this project) |

**Measured, not assumed.** Tempo was recovered from the audio rather than taken
from the prompt: a spectral-flux onset envelope, autocorrelated for the beat
period, then refined by a comb search over period and phase.

| | measured |
|---|---|
| Tempo | **124.018 BPM** (beat 0.483800 s) |
| Bar (4/4) | 1.935200 s |
| First downbeat | 0.69380 s |
| Downbeats in the track | 52 |

**The prompt asked for 124 bpm and the track is 124.02.** Worth recording
because the coarse first pass read 125.00 exactly — that was the
autocorrelation's bin resolution (10.7 ms), not the music. The refined number
is the one in the table.

**The loop.** Three candidates were cut at bar boundaries and scored for
spectral continuity across the splice plus level match. The chosen one is the
best of the three on both counts:

| | start | bars | length | seam rank |
|---|---|---|---|---|
| **A — chosen** | 29.722 s | 16 | **30.9632 s** | **10th percentile** |
| B | 41.333 s | 20 | 38.7040 s | 22nd percentile |
| C | 49.074 s | 16 | 30.9632 s | 33rd percentile |

A 20 ms equal-power crossfade is applied at the wrap: the 20 ms *following* the
loop end is blended into the loop's head, so the last sample flows into the
first.

**How "seam rank" was measured, because "it sounds fine" is not a check.** The
loop was concatenated three times and a frame-to-frame spectral-difference
curve computed over the whole thing. The two internal seams are then ranked
against every other moment in the same audio. Loop A's seams sit at the **10th
and 8th percentile** — the wrap changes the spectrum *less* than 90 % of
ordinary moments in the music do. The raw waveform discontinuity at the wrap is
0.00247, against a largest ordinary sample-to-sample step of 0.33545 in the same
file — **136× smaller**.

| | |
|---|---|
| In the project | `godot/assets/music-loop.ogg`, Vorbis q5, 595 009 bytes |
| Loop SHA-256 | `ea52713afeef1cacdae6ee9b5fe9789ff266c57f7e2b9c6d6380b1e1a85db865` |

**Wired into the game, 2026-10-04 (later).** `CHANGE-BRIEF.md` revision 2.2.0:
an `AudioStreamPlayer` on a dedicated `Music` bus, `loop = true`, starting with
the session and surviving every retry without restarting. Eight behavioural
checks cover it; the engine reports the stream length as 30.9632091522217 s,
which is the cut in the table above.

**Still owed:** the human listen. `CHANGE-BRIEF.md` C4 requires playing the loop
three times back to back and listening at the seam *before* it goes near the
project. The file was placed first and the listen is outstanding — recorded that
way round rather than claimed in the right order. The 30.96 s length is also
short of the 35–40 s the original prompt asked for; that was a request to the
generator, not a requirement of the game, and loop A won on seam quality.

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
