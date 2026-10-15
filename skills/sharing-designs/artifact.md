# Artifact and file targets

## Artifact

1. Write the page as one HTML file, `<plan folder>/review.html`. Embed each mock that passed the privacy check with an iframe at full width, by its relative path `mocks/<file>`. A mock that failed the check stays out, with its screen. Write the journey grids as tables inside a closed `<details>`, as the template shows.
   - Add the Play control: a dialog with one iframe at least 80% of the viewport, Back, Next and Close. Back and Next step through the chosen mocks in Interface flow order. A link inside a mock also navigates the iframe.
   - Add the Show design notes toggle: a checkbox, off on load. On change, add or remove the class `show-notes` on each mock iframe's `documentElement`. On each iframe's load, also inject `<style>[data-annotation]{display:none} html.show-notes [data-annotation]{display:revert}</style>`, so a mock without the rule hides its notes too.
   - List for the owner each mock whose design notes have no `data-annotation`. The page can't hide those.
2. Publish with the Artifact tool. Pass each mock that passed the privacy check as a supporting file at the same relative path. The first publish creates the artifact. A later revision republishes to the URL in the last `Review page:` line.
3. Declare no capabilities. Comments are built in.
4. Tell the owner to share the link from claude.ai with each reviewer. Tell them it is not known whether a reviewer without a claude.ai account can comment.

Read comments with `ArtifactComments` `read` and the URL. Reply and resolve work only on threads a reviewer sent to Claude. List the other threads for the owner as open.

`Unverified:` script access to supporting-file iframes inside a claude.ai artifact. If it fails, Play opens each mock in a new tab, and the notes stay hidden.

`Unverified:` a republish keeps comment anchors. Triage before every republish.

`Unverified:` whether an invited person without a claude.ai account can comment.

## File

Use this when the session has no Artifact tool.

1. Write `<plan folder>/review.html` as one self-contained file: inline CSS, the journey grids, the Play control and the notes toggle as for an artifact, and each mock that passed the privacy check inlined in an iframe `srcdoc`. A mock that failed the check stays out, with its screen.
2. Tell the owner: "This session has no Artifact tool. Send review.html by email or chat, and paste the replies here."
3. Triage pasted comments the same way.
