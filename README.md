# Paper Template

Focus on writing, not getting stuck on how to compile and share.
> You can find some of the introductions in this [Slide](https://blog.spcsky.com/graduate-share/share.html#/%E6%8E%A8%E9%94%80%E7%8E%AF%E8%8A%82) (Chinese only).

## Init

1. Create your paper repository with GitHub's **Use this template**, clone it, and open the clone in your agent. Keep the repository private while working on an unpublished or anonymous draft, and review the publishing workflow before enabling it.
2. Say **“初始化论文项目”** or **“Initialize this paper project”**. On a new repository, the agent can also offer setup when you first ask it to start or plan the paper. Share any details you already know in the first message. For example, “初始化论文项目，主题是缓存隔离，目标是 EuroSys 2027，具体 track 待定。”
3. The agent asks for the missing basics, fills in [Paper project](#paper-project), and saves the setup status and any lasting writing preferences in [AGENTS.md](AGENTS.md). `TBD` is fine. Say **“先跳过初始化”** to work without the setup conversation.

Once configured, new sessions use the saved brief. To change it later, say **“重新配置”** or specify a change directly, for example **“重新配置，目标会议改为 EuroSys 2027”**. The agent keeps other confirmed details and revisits submission rules that depend on the old target. You can also fill in the brief and set the status to `configured` in `AGENTS.md` by hand.

`AGENTS.md` contains the shared instructions. `CLAUDE.md` is a relative symlink to it. Edit `AGENTS.md` directly. Setup runs in the conversation when the agent reads these instructions.

## Paper project

| Field | Value |
| --- | --- |
| Working title or topic | TBD |
| Research question or one-sentence goal | TBD |
| Target venue and edition/year | TBD |
| Track and submission phase | TBD |
| Manuscript stage and language | TBD |
| Official CFP or author instructions | TBD |
| Verified submission rules | TBD |
| Manuscript entry point and bibliography | `paper.tex`, `ref.bib` (template defaults) |
| Draft, experiment results, or figure source paths | TBD |

## Recommended skills

| Skill | Use it for |
| --- | --- |
| [`systems-paper-writing`](https://github.com/Orchestra-Research/AI-Research-SKILLs/tree/main/20-ml-paper-writing/systems-paper-writing) | Systems-paper structure, paragraph planning, contribution framing, and evaluation design. |
| [`academic-research-suite`](https://github.com/Imbad0202/academic-research-skills-codex) | Literature review, citation checks, experiment planning, manuscript review, and revision. |

**Codex.** If you use the [skills CLI](https://github.com/vercel-labs/skills), install the systems writing skill with:

```sh
npx skills add Orchestra-Research/AI-Research-SKILLs --skill systems-paper-writing -a codex -g
```

Install `academic-research-suite` with the [ARS-Codex plugin or direct skill instructions](https://github.com/Imbad0202/academic-research-skills-codex#direct-skill-install-or-update). Open a new Codex conversation and invoke the skills as `$systems-paper-writing` or `$academic-research-suite` when needed.

**Claude Code.** Use the same systems-writing install command with `-a claude-code` in place of `-a codex`. For ARS, follow the [upstream Claude Code installation guide](https://github.com/Imbad0202/academic-research-skills#quick-install).

Project setup works without either skill. Install them separately when you want the corresponding writing or research workflows.

## Background

If you have struggled with any of these situations:

- Latex is difficult to compile. The environment is difficult to install and configure!
- Want to share my latest version of the paper, but where is it?
- Version control.

## Step-by-step

- Turn on your `GitHub Action`.
- Setting up the display page (the pdf of paper).
  - `Setting` > `Pages`
  - Find `Build and deployment`
  - `Source`: `GitHub Actions`
- Each commit triggers a compilation. The PDF is always available as a workflow artifact, and every push to `master` also publishes it to GitHub Pages.
- After GitHub Pages is enabled, the PDF is usually available at:
  - `https://<username>.github.io/<repo>/paper.pdf`
- Push a tag like `v1.0.0` to create a GitHub Release with the compiled PDF attached:
  - `git tag v1.0.0`
  - `git push origin v1.0.0`

> Note: No repository-wide read/write workflow permission is needed. The workflow declares its own least-privilege `permissions`. Pull requests are compiled but never published, and only the PDF (not the sources) is deployed to Pages. If a build fails, the LaTeX logs are uploaded as the `paper-logs` artifact.

See the [commit and paper submission rules](AGENTS.md#commits-and-paper-submissions) for authorship, AI disclosure, and pre-submission checks.

## How to build locally

There are two ways to build locally (in linux, macos, or wsl in windows):

Before building, install the basic dependencies:

- `make` (GNU Make 3.81 as shipped with macOS is fine)
- `xelatex` and `bibtex` (usually from a TeX Live distribution)
- `python3-venv` and `pip3` (for Python-generated figures)
- `ghostscript` (for Adobe Illustrator `.ai` figure conversion)
- `drawio` (only needed when building local `.drawio` diagrams)

- Use `latexmk` to build locally. On a fresh clone, run `make python` first to generate the sample figure `images/template.pdf`. Regenerate any changed figure inputs before rebuilding.
  - `latexmk -xelatex -outdir=build paper.tex`
- Use `make` to build locally (**Recommend**).
  - `make`

We recommend using `make` to build locally, because it can be used to deal the dependencies between files,
generate the figures, and clean up the intermediate files.

The `makefile` include the rules for folder `python`:

- `make python`: Run the python script in the folder `python`.

When you have some python scripts to run, you can put them in the folder `python` and run `make python`.
Usually, the folder `python` contains the scripts for data processing and data visualization (matplotlib).
More details can be found in the `python/` row of the [folder structure](#folder-structure) table.

The Python helper supports macOS's default Bash 3.2 and Linux Bash. It invokes
the local virtual environment's interpreter directly and uses a headless
Matplotlib backend. Empty script directories succeed; installation and script
failures stop the build. Each platform creates its own ignored `python/venv/`.

Also you can use other commands to clean up the intermediate files:

- `make clean`: Clean up the intermediate files generated during the compilation process.
- `make distclean`: Clean up the intermediate files, the generated pdf and figures, and `python/venv`.

## Folder structure

| Path | Description |
| --- | --- |
| `paper.tex` | Main entry point (IEEEtran template by default). You can write directly in this file or split sections into `body/` and include them with `\input{body/...}`. |
| `body/` | Optional folder for per-section `.tex` files so each chapter can be edited independently. The `Makefile` watches `body/*.tex` so changing a section triggers recompilation. |
| `style/` | Custom classes/macros such as `IEEEtran.cls`. Place extra `.sty` or `.cls` helpers here and the build system will pick them up automatically. |
| `images/` | Final figures embedded into the paper. Targets such as `make python`, Draw.io exports, or AI conversions drop generated PDFs/SVGs here to keep sources and outputs separated. |
| `drawio/` | Source `.drawio` diagrams. CI runs `rlespinasse/drawio-export-action` to crop and export them to PDF before compilation. |
| `ai/` | Adobe Illustrator (or other vector) sources. `make aipics` (also executed in CI) uses Ghostscript to convert them into PDF copies stored next to the originals. |
| `fonts/` | Optional font files referenced by AI assets. `make aipics` passes the folder to Ghostscript via `-sFONTPATH` so exported figures stay consistent across machines. |
| `python/` | Data processing / plotting scripts. `make python` runs `python/run.sh`, which creates a `venv` on first use (and reuses it afterwards), installs `requirements.txt`, and executes every `*.py` with `quiet`, `savepdf`, and `savesvg` flags—ideal for reproducible matplotlib figures saved in `images/`. |
| `ref.bib` | Bibliography managed by BibTeX. Included by the `make/bib` dependency so reference edits trigger a rebuild. |
| `latexmkrc` | latexmk configuration mirroring CI flags (including the `style/` search path) for those who prefer `latexmk` over `make`. |
| `Makefile` | Orchestrates LaTeX compilation, diagram conversion, Python helpers, and cleanup targets (`make`, `make clean`, `make distclean`, `make aipics`, etc.). |
| `.github/workflows/` | Automation entrypoints. `build-latex.yml` builds diagrams and figures, compiles the PDF, deploys it to GitHub Pages (`master` only) and attaches it to a GitHub Release (`v*` tags only). `.github/dependabot.yml` keeps the actions it uses up to date. |

> Tip: keep raw sources (`drawio/`, `ai/`, `python/`) versioned. The GitHub Action regenerates PDFs/figures on every push, so you only need to track the authoritative inputs.

## License

See [LICENSE](LICENSE).
