# godot/assets/

Everything here is a **placeholder** until Assignment 2's generated assets land.

| File | What it is | Replaces | To be replaced by |
|---|---|---|---|
| `death-laugh.ogg` | 3.42 s of **silence**, generated with `ffmpeg anullsrc` | Assignment 1's meme laugh, third-party with no documented permission | a generated sound effect |
| `death-laugh-cat.png` | a flat colour card reading PLACEHOLDER | Assignment 1's meme cat image, same rights problem | generated art, or the reaction is cut |

The duration is 3.42 s on purpose: `test_game.gd`'s
`enemy-death-reuses-the-reaction` asserts the reaction's remaining time, so a
placeholder of the same length keeps the suite green without weakening an
assertion. The assignment forbids deleting a failing assertion to get a green
report; this keeps it passing honestly instead, and says so here.

**Neither Assignment 1 asset was copied into this repository**, so no
undocumented-rights file exists anywhere in its history.
