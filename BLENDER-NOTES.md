# BLENDER-NOTES.md — learning the window

Assignment 3 asks for a short session spent just looking at Blender before any
prompting, and for six parts of the interface named and described **in my own
words**, with one screenshot of my own session.

- **Blender:** 5.2.2 LTS (build 2026-09-15), Windows 11, Chinese interface
- **Session:** 2026-10-14, default startup file, Cube selected
- **Screenshot:** `design/blender/learn-the-window.png` — my own session, not a
  manual figure

![my Blender session, Cube selected](design/blender/learn-the-window.png)

> **Note on authorship.** The descriptions below are mine. Claude set out the
> headings and the screenshot and asked me what I had seen; it did not write
> the descriptions, because the assignment asks for my words and because a
> description I did not write would be worth nothing when a TA asks me to point
> at something.

---

## 1. 3D viewport — 3D 视口

> 中间是视图。

The large area in the middle. The cube, the camera (the wireframe pyramid at
the upper left) and the light all live in it, and it is what I orbit, pan and
zoom around.

## 2. Sidebar (N panel) — 侧栏

> 按了 n 之后属性之类的，条目、工具、视图…… 都在右边。

It opens over the right edge of the viewport when I press **N**, with tabs
stacked vertically down its edge. On the 变换 (Transform) tab it shows the
selected object's 位置 (location), 旋转 (rotation), 缩放 (scale) and 尺寸
(dimensions).

What that panel shows for the default cube is the reason this session happened
before the brief: **尺寸 X/Y/Z all read `2 m`, with 缩放 all `1.000`.** So one
Blender unit is one metre here, the cube is two metres across, and the sizes I
wrote into `CHANGE-BRIEF.md` are measured against something I have actually
seen rather than guessed.

*(To check when I next open Blender: the fourth vertical tab on that sidebar.
I wrote "动画" from memory, but in the screenshot the tabs read 条目 / 工具 /
视图 and then **MCP for Blender**, which is the add-on's own tab. I would
rather correct this than leave a description that does not match my own
screenshot.)*

---

## 3. Toolbar — 工具栏

**[ my words needed ]** — the narrow vertical strip of icons down the **left**
edge of the viewport in my screenshot (the arrow at the top, then the cursor,
move, rotate, scale icons below it).

What is it for, in my own words? What happens when I pick a different one?

## 4. Outliner — 大纲视图

**[ my words needed ]** — the panel at the **top right** of my screenshot, the
one listing 场景集合 → Collection → Camera, Cube, Light, with an eye icon and
a camera icon beside each row.

What does it show me that the viewport does not?

## 5. Properties editor — 属性编辑器

**[ my words needed ]** — the tall panel at the **bottom right**, with the
column of small tab icons down its left side, currently showing 变换 with 位置
/ 旋转 / 缩放 and below that 关系, 集合, 实例化, 可见性 and so on.

How is this different from the sidebar in §2, which also shows 位置 / 旋转 /
缩放?

## 6. Mode selector — 模式选择器

**[ my words needed ]** — the dropdown at the **top left of the viewport
header**, currently reading **物体模式** (Object Mode).

What is the other mode I switched to, and what changed when I did?

---

## What this session changed about the brief

**[ my words needed, one or two lines ]** — the assignment's reason for doing
this first is *"so your sizes and budget are informed guesses and not blind
ones"*. Did seeing the 2 m cube at that zoom level change my sense of how big
0.70 m, 1.00 m and 1.50 m actually are?

---

## The hand edit

I made two. The first one I undid, and that is worth recording as much as the
one that stayed.

### First try — the spike trap, moved and moved back

> 打开了尖刺文件，改了一下 xy 轴,学会了如何调整模型位置。
>
> *(Opened the spike file, changed the x and y axes, learned how to move a
> model.)*

Then I put it back where it was, because I was only trying it out. When Claude
compared `spike_trap.blend` against what the build script produces, every
coordinate matched and the file's timestamp had not moved: the edit left no
trace at all. The assignment says a TA may ask me to show which part I edited
by hand, and an edit I reverted is not something I can show. Worth knowing
before the deadline rather than after it.

### The one that stayed — the slime's eyes

In the Godot render the eyes looked too small and sat too high to read at
game size, next to a player who is 1.75 m. So I selected each eye cube in the
viewport and scaled it with **S**, then nudged it down.

|  | before | after |
|---|---|---|
| `Slime_Eye_1` | scale 1.000, z 0.6400 | **scale 1.526**, z 0.6129 |
| `Slime_Eye_2` | scale 1.000, z 0.6400 | **scale 1.570**, z 0.6141 |

The two are not identical — 1.526 against 1.570 — because I sized them by eye
rather than by typing a number. I am leaving the asymmetry: it is what a hand
edit looks like, and at game size it reads as character rather than as error.

Claude applied the scale into the mesh afterwards (`Ctrl+A` → Scale, which the
build scripts do for every object they create) so the exported `.glb` carries
no node scale, and re-ran the check: the bounding box is still exactly
**1.375 × 1.000 × 1.375 m** with its origin on the floor, so the edit changed
the look without breaking anything `CHANGE-BRIEF.md` promised.

### What it taught me about the interface

**[ my words needed, one or two lines ]** — I now know how to move an object
(**G**) and scale one (**S**). What surprised me, or what I would want to know
next time? For example: how the sidebar's 位置 / 缩放 numbers change live as I
drag, or the difference between moving an object and moving its origin.
