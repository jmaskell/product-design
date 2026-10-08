# Mocks

## Where mocks go
Write mocks to `docs/plans/<slug>/mocks/`, or to the plan directory the project names.

## Component source
The project metadata line `Component source:` names a gallery route, a registry URL, or `none`.

- Gallery or registry: compose mocks from the extracted component HTML and the project's compiled CSS. Never type component classes or tokens again. Stamp each mock with `<!-- component-source: <source> @ <sha> -->`. When the project has an extraction script, use it. When it has none, read the gallery source files and reuse their markup.
- `none`: hand-build self-contained HTML with the project's tokens. Write in design.md: "Mocks are hand-built: no component source."

## What a mock shows
- One file per option, named `option-<letter>-<short-name>.html`, then `chosen-<screen>.html`.
- The key states from the state table: default, plus empty and error where they exist.
- Real content from the product's domain. No lorem ipsum.
- A narrow-width view when the product's users use phones.

## New patterns
A region that no existing component covers is a new pattern. Mark it in the mock with a visible outline and list it under "New patterns" in design.md.
