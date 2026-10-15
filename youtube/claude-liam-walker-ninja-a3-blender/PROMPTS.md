# PROMPTS.md — the prompts this film shows, and their status

## B00 — the composer ask

**Status: RECONSTRUCTION.** Illustrative. It is not a transcript, there is no
claim it was ever sent, and no build receipt is shown. The label is on screen
for the whole beat and the narration says it in the first sentence.

> Please use Walker to convert my game design document about a cyber-ninja in
> a torchlit dungeon into three simple 3D assets I can put in Godot: the wall
> torch, the pop-up spike trap and the slime. Build them in my open Blender
> through the MCP, from basic shapes only, at the sizes my 2D level already
> uses.

## B11 — Your Turn

**Status: USABLE.** Meant to be run, and bounded: one node, one prediction,
one look.

> In walker-ninja, add an OmniLight3D as a child of the Torch in
> `scenes/asset_showcase.tscn`, with a range derived from the 2D glow in
> `_draw_torch`. Write the predicted range in the commit message before you
> run it, then look at the frame.

The prediction is the point. The 2D glow is 16 nested discs with an outer
radius of 60 px, and at 16 px = 1 m that is **3.75 m**. `check_assets_3d.gd`
measures geometry and a light is not geometry, so the check will pass whatever
range is used. The instruction is therefore to look — which is this film's
lesson restated as homework.

## The prompts that actually built the assets

Not shown on screen, because they are not prompts in the usual sense. Each
asset was built by the MCP executing a file:

```python
exec(compile(open(r"...\tools\blender\build_spike_trap.py").read(), path, "exec"))
```

so the thing to read is the script, not a prompt. All three are in
`tools/blender/`, and the same files run standalone as the assignment's
script-route fallback. `../../FRICTIONAL.md` has the session they were written
in, including the three setup failures.
