# Paper Template

Focus on writing, not getting stuck on how to compile and share.
> You can find some of the introductions in this [Slide](https://blog.spcsky.com/graduate-share/share.html#/%E6%8E%A8%E9%94%80%E7%8E%AF%E8%8A%82) (Chinese only).

## Background

If you have struggled with any of these situations:

- Latex is difficult to compile. The environment is difficult to install and configure!
- Want to share my latest version of the paper, but where is it?
- Version control.

## Step-by-step

- Turn on your `GitHub Action`.
- Enable `Actions` read/write permissions in the repo.
  - `Setting` > `Actions` > `General`
  - Find `Workflow permissions`
  - `Select read and write permissions`
- Setting up the display page (the pdf of paper).
  - `Setting` > `Pages`
  - Find `Build and deployment`
  - `Source`: `Deploy from a branch`
  - `Branch`: `gh_actions_builds`
  - Note: This branch to be available after completing by `GitHub Action`.
- Each commit triggers a compilation that generates the latest files (the pdf of paper).

## How to build locally

There are two ways to build locally (in linux, macos, or wsl in windows):

- Use `latexmk` to build locally.
  - `latexmk -xelatex -outdir=build paper.tex`
- Use `make` to build locally (**Recommend**).
  - `make`

We recommend using `make` to build locally, because it can be used to deal the dependencies between files,
generate the figures, and clean up the intermediate files.

The `makefile` include the rules for folder `python`:

- `make python`: Run the python script in the folder `python`.

When you have some python scripts to run, you can put them in the folder `python` and run `make python`.
Usually, the folder `python` contains the scripts for data processing and data visualization (matplotlib).
More details can be found in the section [python](#python).

Also you can use other commands to clean up the intermediate files:

- `make clean`: Clean up the intermediate files generated during the compilation process.
- `make distclean`: Clean up the intermediate files and the generated pdf.

## Folder structure

| Path | Description |
| --- | --- |
| `paper.tex` | Main entry point (IEEEtran template by default). All sections in `body/` are referenced from here via `\\input`. |
| `body/` | Holds per-section `.tex` files so each chapter can be edited independently. The `Makefile` watches `body/*.tex` so changing a section triggers recompilation. |
| `style/` | Custom classes/macros such as `IEEEtran.cls`. Place extra `.sty` or `.cls` helpers here and the build system will pick them up automatically. |
| `images/` | Final figures embedded into the paper. Targets such as `make python`, Draw.io exports, or AI conversions drop generated PDFs/PNGs here to keep sources and outputs separated. |
| `drawio/` | Source `.drawio` diagrams. CI runs `rlespinasse/drawio-export-action` to crop and export them to PDF before compilation. |
| `ai/` | Adobe Illustrator (or other vector) sources. `make aipics` (also executed in CI) uses Ghostscript to convert them into PDF copies stored next to the originals. |
| `fonts/` | Optional font files referenced by AI assets. `make aipics` passes the folder to Ghostscript via `-sFONTPATH` so exported figures stay consistent across machines. |
| `python/` | Data processing / plotting scripts. `make python` runs `python/run.sh`, which provisioning a `venv`, installs `requirements.txt`, and executes every `*.py` with `quiet` and `savepdf` flags—ideal for reproducible matplotlib figures saved in `images/`. |
| `ref.bib` | Bibliography managed by BibTeX. Included by the `make/bib` dependency so reference edits trigger a rebuild. |
| `latexmkrc` | Local latexmk configuration mirroring CI flags for those who prefer `latexmk` over `make`. |
| `Makefile` | Orchestrates LaTeX compilation, diagram conversion, Python helpers, and cleanup targets (`make`, `make clean`, `make distclean`, `make aipics`, etc.). |
| `.github/workflows/` | Automation entrypoints. `build-latex.yml` builds diagrams, compiles the PDF, pushes it to `gh_actions_builds`, and optionally publishes releases. |

> Tip: keep raw sources (`drawio/`, `ai/`, `python/`) versioned. The GitHub Action regenerates PDFs/figures on every push, so you only need to track the authoritative inputs.

## Emmm...

Let's write here first, I'll add more later..
