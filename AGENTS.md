# product-design plugin

Skills-only Claude Code plugin. The skills are in `skills/`, shared text in `references/` and `templates/`, eval cases in `evals/`.

Every change to `skills/`, `references/`, `templates/`, `evals/` or `scripts/` updates `README.md` in the same commit when the README describes it.

Run the three check scripts before you commit:

- `bash scripts/check-portability.sh`
- `bash scripts/check-skill-size.sh`
- `bash scripts/check-readme.sh`
