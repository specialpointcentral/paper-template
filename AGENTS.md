# Paper repository instructions

Read the [Paper project](README.md#paper-project) section before working on the manuscript. It records the paper brief, submission target, and source paths. The [Init guide](README.md#init) is the user-facing entry point. Edit `AGENTS.md` directly when updating these instructions.

## Project setup

- Initialization status: `uninitialized`
- Project-specific writing preferences: none recorded.

Read the status from the current file before deciding whether to offer setup, including in an ongoing conversation.

| Status | Behavior |
| --- | --- |
| `uninitialized` | On the first request to start or plan the paper, offer a short setup conversation. For a narrowly scoped edit, review, or build, do the requested work and ask only for details it needs. Unrelated tasks proceed as usual. |
| `configured` | Use the saved brief. Ask for an unresolved detail only when the current task needs it. |
| `deferred` | Proceed with the available context. Reopen setup when the user asks. |

Treat requests such as “初始化论文项目”, “初始化”, “initialize this paper project”, “重新配置”, and “reconfigure paper project” as setup requests when they refer to this repository. They work in any state. If the user says to skip setup, record `deferred` for an uninitialized project unless the request is read-only. Leave a configured project's status as-is if the user cancels reconfiguration.

### Setup conversation

1. Read the existing brief and relevant manuscript files. Start with details the user already supplied. Treat the sample title, example authors, and IEEEtran class as template defaults. Confirm any inferred project details before recording them.
2. Ask for the working title or topic, research question or one-sentence goal, and intended venue, edition/year, and track in a short first round. Follow up only where useful for the current project, for example about the manuscript stage and language, submission phase, existing draft and evidence, or durable writing preferences. Accept `TBD` for undecided fields.
3. For reconfiguration, summarize the current values relevant to the request. Apply an unambiguous change such as “重新配置，目标会议改为 EuroSys 2027” directly. When the target changes, clear the old CFP link and submission rules if they no longer apply, and confirm any track or phase that depended on the previous target. Use `TBD` until the replacement is known. For a broader or ambiguous request, clarify the changes before saving.
4. Write the agreed details under [Paper project](README.md#paper-project). Preserve existing values unless the user changes them. Update the status to `configured` after saving the brief, even if some fields are `TBD`. In `AGENTS.md`, update only the status and any confirmed project-specific writing preferences. Keep the reusable rules and symlinks intact. If the brief or status is missing, ask before rebuilding it from assumptions.
5. Report what was saved and which details are still open. Setup edits the two Markdown files. A change to the manuscript title, author list, document class, build workflow, or publication settings requires a corresponding request. Keep confidential details out of files that will be shared.

## Writing and research

- For systems-paper structure, argument, section planning, page budget, or evaluation framing, use `systems-paper-writing`. Make the problem, gap, key insight, and contributions explicit. Connect each main contribution to the section and evidence that support it. Explain consequential design trade-offs and the scope of evaluation.
- For literature work, citation verification, experiment planning, manuscript review, or revision, use `academic-research-suite` in Codex or the upstream Academic Research Skills plugin in Claude Code. Load the workflow that matches the task. Use its citation workflow with `systems-paper-writing` when both are relevant. See [Recommended skills](README.md#recommended-skills) for installation. If a skill is unavailable, mention it when it affects the task and do the parts the available material supports.
- Preserve the author's argument, terminology, and qualifications. Read the relevant section and evidence first, and keep edits within the requested scope. A review produces findings and suggested revisions unless the user asks for source edits.
- Keep citations, experiment numbers, and claims traceable. Check that a source exists and supports the specific claim before citing it. Tie quantitative claims to actual runs or data and record the relevant workload, baseline, metric, and conditions where available. Mark open items with `TODO` or `CITATION NEEDED` in a draft. Never invent citations, author details, measurements, or claims of novelty.

## Manuscript files and validation

- The default entry point is `paper.tex`, with optional section files in `body/` and BibTeX entries in `ref.bib`. Follow the active manuscript's includes, labels, and citation conventions. Edit figure sources in `python/`, `drawio/`, or `ai/` as appropriate. `images/` holds figures used in LaTeX. See the [folder structure](README.md#folder-structure).
- After LaTeX, bibliography, or figure edits, follow the [local build guide](README.md#how-to-build-locally). Generate the required figures before running `latexmk` directly. Check the log for unresolved citations and references, inspect affected pages in the PDF when possible, and report any check you could not complete.

## Commits and paper submissions

- **Git commits.** When asked to commit, inspect the staged diff and commit message. Include only the requested changes and use the Git identity configured by the user for this repository. Never set an AI agent or model as the commit author or committer. Never add a `Co-authored-by` trailer for yourself or any AI agent, model, or bot. Use a human co-author trailer only when the user supplies that attribution.
- **Paper authorship.** Use the author list, order, affiliations, and corresponding-author details confirmed by the human authors. Never list an AI agent, model, or tool as an author or co-author in the manuscript or submission system. Record actual AI use in the disclosure required by the target venue and have the authors review the wording before submission.
- **Before submission.** Verify the official rules for the exact venue, edition, track, and submission phase. Check the format, page and appendix limits, anonymity, and AI-use requirements. Record the official link, checked rules, and date in the brief. IEEEtran is the starter class. Apply a venue's class only when the task calls for a format change. Review the final PDF and supplementary materials, including PDF metadata and artifact links when anonymity is required.
- **Permission to share.** Get explicit authorization before pushing, publishing, submitting, or uploading unpublished materials to external services. A push to `master` or a `v*` tag can trigger publication through the bundled workflow.
