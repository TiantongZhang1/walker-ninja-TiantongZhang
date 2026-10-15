# BUILD-PROMPT.md — how to rebuild this film from the repository

From the repository root. The toolkit lives beside it at `../brutalist.art-main`.

## Environment

```
PYTHONUTF8=1
ART_NO_DRAWTEXT=1
ART_HOME=../brutalist.art-main
GODOT=.../Godot_v4.7.2-stable_win64.exe
BLENDER=.../Blender/blender.exe
```

Python 3.12 with Pillow. Node 22. `ffmpeg` on PATH.

## 1 — rebuild the assets, if you want to start from nothing

```bash
"$BLENDER" -b --factory-startup --python-exit-code 1 --python tools/blender/build_torch.py
```

Each script prints its own object count, triangle count, bounding box and base
height. Exporting needs `tools/blender/export_glb.py`, which the MCP path
calls; standalone, add a call to `save_and_export` at the end.

## 2 — check the assets before filming them

```bash
"$GODOT" --headless --path godot --import
"$GODOT" --headless --path godot --script res://tests/check_assets_3d.gd
```

Exit 0 or the film is about something that does not hold.

## 3 — evidence images, then the beat sheet

```bash
python tools/compose_a3_evidence.py
python tools/build_a3_beat_sheet.py
```

Order matters: the beat sheet embeds the images as data URIs, and it slices
every code excerpt out of the file on disk by line range. **If a build script
is edited, the line numbers in `build_a3_beat_sheet.py` must be re-checked** —
the script asserts the excerpt is ≤ 14 lines but cannot tell whether it still
starts in the right place.

## 4 — narration, then bind to it

```bash
python $ART_HOME/runtime/scripts/generate_audio_kokoro.py <REEL>
```

Narration first, timing second. Cue positions are fractions of the *measured*
audio.

## 5 — gate before rendering

```bash
cd $ART_HOME
./art godot-gamedev --check <REEL> --game <REPO>/godot < /dev/null
```

Expect `"status": "PASS"`. Note the `< /dev/null`: `./art` subcommands read
stdin, and inside a `while read` loop they consume the loop's input and report
every component as NOT RENDERABLE. That cost ten minutes during Assignment 2.

## 6 — pilot, then batch

```bash
python $ART_HOME/runtime/scripts/remotion_scenes.py <REEL> --only B02 --force
# LOOK AT IT. Then:
python $ART_HOME/runtime/scripts/remotion_scenes.py <REEL>
```

The pilot exists because the panel clips. **Excerpts ≤ 14 lines, note values
≤ 100 characters.** `codeFontSize` cannot go below 23.

Do **not** pass `--outro`: that builds `OutroSeries` / `OutroCTA` from
`ABOUT.MD` / `AUTHOR.MD`, which this reel does not have.

## 7 — master

```bash
cd $ART_HOME
./art final <REEL> --height 2160 --fps 30 --out <REEL>/exports/landscape
python runtime/qc/final_frame_check.py <REEL> --mp4 <REEL>/exports/landscape/<slug>.mp4
```

Gate V lives at `runtime/qc/`, not `runtime/scripts/`, and takes the reel
positionally with the master as `--mp4`.

## Known traps

- `./art final` rewrites `_qc/REPORT.md` and drops the human half. Re-append.
- It names the output after the reel **slug**, so rename to the locked title
  and recompute the SHA-256 afterwards.
- The title must stay **≤ 26 characters** or the outro card overflows Gate V's
  safe right edge. `NewWalker3D_TiantongZhang` is 25.
