# SOURCES.md — this film's own materials

The game's provenance is `../../SOURCES.md`, §9 for Assignment 3. This file
covers what the **film** is made of.

## Images

| | what it is |
|---|---|
| `media/blender-spike-angles.png` | Four views of the trap, rendered from the **live Blender session** by the MCP's `look` tool. Not a screen recording and not a redraw. |
| `media/blender-slime-subdiv1.png` | The slime at subdivision 1, same method. Kept because the film compares it with what replaced it. |
| `media/blender-slime-subdiv2.png` | The slime at subdivision 2, same method. |
| `media/slime-before-after.png` | The two above, composed side by side by `tools/compose_a3_evidence.py`. |
| `media/check-output.png` | The headless check's own stdout, set in Consolas by the same script. Values verbatim. |
| `media/hand-edit-slime-eye.png` | **The author's own Blender window**, screenshotted by them. The only frame in this film that a person had to produce. |
| `media/godot-showcase.png` | A frame from a real run of `asset_showcase.tscn`, captured by a short script that renders eight frames and saves the viewport. |

Both composed images are made at **1529 × 987**, the `GodotDevWorkbench`
right-hand image area measured off a rendered master during Assignment 2.

## Narration

**Kokoro-82M**, local, Apache-2.0, voice `am_onyx`. No API, no account, no
cost. 12 of 13 beats; B12 is the locked outro and carries no narration by
rule.

## Editor views

Every code panel is `GodotDevWorkbench`, reused rather than redrawn —
`./art scenes` was run first and reported it as the match. Views are labelled
**"Godot editor reconstruction · source-backed teaching view"** on screen.
Every displayed line is sliced out of the file on disk by line range when the
beat sheet is built, so a beat cannot drift from its source.

Two of the three excerpts are Python rather than GDScript, because two of the
three components are Blender build scripts. The panel is a teaching view of a
source file, not a claim about which editor the file was written in.

## Outro

`ClaudeTitleOutro`, locked per `OUTRO-LOCK.md`: exact title, `@NikBearBrown`,
one slug-seeded mascot, no subline, existing stock jingle only, no narration.

## Upstream consulted

`skills/make/godot-gamedev/SKILL.md` and its `references/evidence.md`;
`RENDER-TARGETS.md`; `OUTRO-LOCK.md`. Assignment 2's reel was read for the
real prop shapes of `ClaudeComposerAsk`, `BrutalistHesitantWriter` and
`ClaudeVerdictArtifact` — in A2 two component names were invented and rejected
by `./art scenes --check`, and that is not being repeated.

No secrets, no `.env` contents and no absolute developer-machine paths are
embedded in any reusable skill or scene.
