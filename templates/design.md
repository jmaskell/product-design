# Design: <id>
Write every section by references/plain-prose.md (two levels above the skills).

## Interface flow
<entry → steps → exit, one line per step, linking each mock>

## Mocks
<file — what it shows — component source and SHA, or "hand-built: no component source">

## States
| Screen | State | What the person sees | How they got here |
|---|---|---|---|

## Needed now
<screen>: <what the person needs to know at that moment, and nothing else>

## Build notes
<chosen screen>: (at most 8 bullets; leave out what doesn't apply)
- Groups, in order: <a>; <b>; <c>
- Page header: <actions>
- After <action>: <where the person lands>
- <message> goes to: <recipient>
- From elsewhere: <value> — read-only | editable copy
- Unavailable: <action> — <reason>
- Like: <existing screen file or component source>

## Copy
<screen>: <each string the screen shows now, one per line>

## Accessibility decisions
<focus destinations, announcements, not-by-colour-alone calls>

## Interaction test plan
- <flow>: <entry> → <steps> → <expected outcome>

## New patterns
<name — why no existing component fits — where it is used>
