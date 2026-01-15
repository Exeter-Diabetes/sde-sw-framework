# Contributing / Working practices

Thanks for contributing to this  repository. This document describes the working practices for raising issues, creating pull requests (PRs), and publishing the documentation. Follow these steps to help keep contributions clear, reviewable and safe.

## Quick checklist for contributors

- Fork the repository and create a feature branch for your change.
- Open an issue first if your change is non-trivial.
- Create a PR that targets `dev` from a feature branch with a clear title and description.
- Link the PR to the issue (if any), include a short summary and a checklist of what changed.

## Branching and branch names

- Use descriptive branch names. Examples:
  - `fix/typo-data-spec`
  - `feat/add-example-measurement`
  - `chore/update-workflow`

## Issues

- Use issues to propose new features, report problems, or request changes to the data spec.
- When opening an issue include:
  - A short title summarising the request.
  - Reproducible steps or a small example (when relevant).
  - The proposed change or expected behaviour.
  - Any security or privacy concerns.

## Pull requests (PRs)

What to include in the PR description:

- A short summary of what the PR does.
- The motivation for the change and links to any related issue(s).
- A checklist of what reviewers should verify (see PR checklist below).

PR checklist (suggested)

- [ ] The PR has a clear title and description.
- [ ] There is a linked issue if the change is non-trivial.
- [ ] For new conditions: a `conditions/{condition-name}/` directory with `description.md` file has been added.
- [ ] Condition descriptions follow the format: headings for Description, Rules, Scripts, and Origins sections.
- [ ] Workflow changes documented and tested (e.g., local test or documented steps to run on Actions).

## Review process

- At least one reviewer should approve changes before merging.
- For changes that affect published outputs (site, CSVs, layout), reviewers should:
  - Build the site locally (instructions below) and confirm the `index.html` and links look correct.
  - Inspect CSVs for expected headers and sample values.

## How to build and preview locally

For detailed build instructions and troubleshooting, see [html/README.md](html/README.md).

Quick start:

1. Install pandoc (macOS: `brew install pandoc`, Linux: `sudo apt-get install pandoc`)
2. From the repository root run:

```bash
bash html/generate-site.sh
```

3. Open `site/index.html` in your browser to preview

For detailed information about the build process, see [html/README.md](html/README.md).

## Publishing and workflows

- This repository uses a manual GitHub Actions workflow (`.github/workflows/publish-pages.yml`) to build the site and publish to the `gh-pages` branch.
- The workflow runs the `scripts/generate-site.sh` script to generate condition pages from markdown files in `conditions/`.
- The workflow is intentionally `workflow_dispatch` (manual) only. To run the workflow:
  - Go to the repository on GitHub → Actions → "Publish data specification" → Run workflow.
  - The workflow will build the site and deploy it to GitHub Pages.

## Adding or modifying conditions

For detailed information about the site generation and condition structure, see [html/README.md](html/README.md).

Quick summary:

1. Create a new directory: `conditions/{condition-name}/`
2. Add a `description.md` file with sections: Description, Rules, Scripts, and Origins
3. Optionally add a `code_lists/` subdirectory with CSV files
4. Run `bash html/generate-site.sh` to test locally

## Commit messages

- Keep commit messages concise and meaningful. Use prefixes like `fix:`, `feat:`, `docs:`, `chore:` where helpful.

## Maintainers and escalation

- If you're unsure how to proceed, open an issue and tag a maintainer or team. If a PR requires special permissions (for example changes to the Pages settings), note that in the PR so maintainers can take action.

Thank you for contributing — clear issues and small, focused PRs make reviews fast and reliable.