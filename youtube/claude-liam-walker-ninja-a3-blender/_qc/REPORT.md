# Gate V — visual QC report

Frames sampled: 26  ·  BLOCKER: 0  ·  MAJOR: 0

Clean — no BLOCKER/MAJOR defects. ✓
---

## Human inspection — the master, looked at

Gate V samples frames and measures contrast, fill and safe areas. It does not
know whether a beat says what it claims. Thirteen frames, one per beat, were
pulled out of the master and laid out as a contact sheet.

**Three defects were caught this way, two of them after Gate V had passed.**

`B03` carried the raw 644 x 644 capture from the MCP's `look` tool. A square
image in a 1.549 panel fits by height and throws away 35 % of the width — the
same mistake Assignment 2 made before that panel was measured. Re-laid at
1529 x 987, with the asset's measurements in the recovered width.

`B08` was worse, and it was the beat that mattered most: the one piece of
evidence only the author could produce. It carried the whole 2000 x 1088
Blender window, and at panel size the title bar, the selected eye and the
Properties values were all illegible. Cropped to those three regions now.
Nothing is redrawn; every pixel is from the author's own screenshot.

`B10` was caught by Gate V rather than by eye, and is worth recording because
it was self-inflicted. Checking the film against the assignment's list found
that the Verdict stated what was checked, what was uncertain and what Claude
got wrong, but not the human and AI contributions or the source revision
shown. Adding them took the card from eight lines to eleven, it overflowed
the title-safe bottom edge, and `./art final` refused the cut. Eight lines
again, each under 65 characters, all six requirements still met.

**What was checked and is right.** Thirteen beats present and in order; the
walker bookends in sequence; B01's single-word correction completes; code
readable at 1x in B06 with its highlight on the line the narration names; the
editor-reconstruction label on every workbench beat; the evidence labels
(`captured from the running Blender`, `headless output`, `my own session`) on
the beats that need them; the locked outro card with the exact title, one
mascot and no subline.

**Carried over, not fixed.** Five beats render an empty code panel across the
left of the frame — `GodotDevWorkbench`'s `asset` layout and the teaching
contract together, since a result beat may not carry a source excerpt. Every
evidence image is composed to the panel's measured size so the right half is
full. Assignment 2's `SHOTLIST.md` has the alternatives that were rejected.

**The full watch — done 2026-10-15, by the author.** A contact sheet is not a
viewing, so this was the one check in this report that could not be made here.
The author watched all 3:28 at playback speed and reported no problems.

That is a one-sentence pass over a thirteen-beat film, and it is recorded as
one sentence rather than expanded into findings nobody gave. It is the same
shape as the human check in `TEST-REPORT.md` section A6, and weaker evidence
than a failure with detail would have been.

What it does close: every defect listed above was found by Claude sampling
frames, and a person has now watched the cut end to end without finding
another.
