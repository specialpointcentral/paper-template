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

### `body`

### `style`

### `images`

### `drawio`

### `ai`

### `python`

### others

## Emmm...

Let's write here first, I'll add more later..
