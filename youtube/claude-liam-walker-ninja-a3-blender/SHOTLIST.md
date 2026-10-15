# SHOTLIST.md — what is on screen, beat by beat

`godot-gamedev walker` · 13 beats · **208.00 s, 3:28 measured** off the
finished master. Durations follow the narration.

Teaching contract **`code-then-result-v1`**: three code excerpts, each
immediately followed by the result those lines produce, bound by hash in
`gamedev-evidence.json`.

| # | act | surface | on screen |
|---|---|---|---|
| B00 | ASK | `ClaudeComposerAsk` | The reconstructed prompt, labelled **reconstruction — illustrative, not a transcript**. Three result lines: built not generated, sizes from the 2D game, no library or generator. |
| B01 | RESULT | `BrutalistHesitantWriter` | "Claude **generated** three assets." — **generated** struck, **built** written in its place. Three cards: built, off-by-rule, unchanged. |
| B02 | BUILD | `GodotDevWorkbench` code | `build_spike_trap.py` 98–111, the tooth loop. Four cues: the derived pitch, the x placement, the location tuple, the transform apply. |
| B03 | RESULT | `GodotDevWorkbench` asset | `blender-spike-angles.png` — four views of the trap, captured from the live Blender session through the MCP `look` tool. |
| B04 | BUILD | `GodotDevWorkbench` code | `build_slime.py` 98–109, `fit_to_size()`. Cues on the measured bounds, the target, the factor, the vertex pass. |
| B05 | RESULT | `GodotDevWorkbench` asset | `slime-before-after.png` — subdivision 1 beside subdivision 2, both from the live session. |
| B06 | BUILD | `GodotDevWorkbench` code | `check_assets_3d.gd` 150–161, `_collect()`. Cues on the accumulated transform, the root exception, the AABB, the recursion. |
| B07 | RESULT | `GodotDevWorkbench` asset | `check-output.png` — the headless run's own stdout, twelve measurements, ALL CHECKS PASSED. |
| B08 | RESULT | `GodotDevWorkbench` asset | `hand-edit-slime-eye.png` — **the author's own Blender window**, screenshotted by them. Not a reconstruction. |
| B09 | RESULT | `GodotDevWorkbench` asset | `godot-showcase.png` — a frame from a real run of `asset_showcase.tscn`. |
| B10 | VERDICT | `ClaudeVerdictArtifact` | Eight lines: built not generated, the six services off, sizes traced, 12 measurements, the broken check, two revisions on sight, the one-sentence human check, and what is not shown. |
| B11 | TURN | `ClaudeComposerAsk` | One bounded change — give the torch a light — with the predicted range derived from the 2D glow, and the note that the check will not notice either way. Liam signs off. |
| B12 | OUTRO | `ClaudeTitleOutro` | Locked card. `NewWalker3D_TiantongZhang`, `@NikBearBrown`, one mascot, no subline, no narration. |

## Labels carried on screen

- B00 is labelled a reconstruction, in the running text and in the narration's
  first sentence.
- B03 and B05 say **captured from the live Blender session through the MCP**.
  They are renders of the author's running Blender, not screen recordings and
  not redraws.
- B07 says **headless output**. It is the run's own stdout.
- B08 says **my own session — a photograph of the window, not a
  reconstruction**, because it is the one frame nobody else could produce.

## A known limitation, carried over from Assignment 2

B03, B05, B07, B08 and B09 use `GodotDevWorkbench` in `asset` mode, which lays
out `{code}{image}`. Their `code` is empty, because the teaching contract says
a result beat may not carry a source excerpt, so the left panel renders as a
dark box with one blank line number. Every evidence image is composed to the
panel's measured **1529 × 987** so the right half is at least full. The empty
left half is the cost of reusing the shared component correctly, and it is
recorded rather than hidden. Assignment 2's `SHOTLIST.md` has the longer
version and the three alternatives that were rejected.

## What this film does not show

- The 2D game. Covered by the Assignment 2 film, unchanged by A3.
- The torch and the slime building, step by step. One asset is taught in
  depth — the trap — and the other two through the two decisions that were
  actually interesting: the fit, and the subdivision.
- The assets inside the 2D game. Not asked for until later assignments.
