# Artifact and file targets

## Artifact

1. Write the page as one HTML file, `<plan folder>/review.html`. Embed each mock that passed the privacy check with an iframe at full width, by its relative path `mocks/<file>`. A mock that failed the check stays out, with its screen. Write each journey grid as a table, in a wrapper with `overflow-x: auto` so that many stages scroll sideways.
2. Publish with the Artifact tool. Pass each mock that passed the privacy check as a supporting file at the same relative path. The first publish creates the artifact. A later revision republishes to the URL in the last `Review page:` line.
3. Declare no capabilities. Comments are built in.
4. Tell the owner to share the link from claude.ai with each reviewer. Tell them it is not known whether a reviewer without a claude.ai account can comment.

Read comments with `ArtifactComments` `read` and the URL. Reply and resolve work only on threads a reviewer sent to Claude. List the other threads for the owner as open.

`Unverified:` a republish keeps comment anchors. Triage before every republish.

`Unverified:` whether an invited person without a claude.ai account can comment.

## File

Use this when the session has no Artifact tool.

1. Write `<plan folder>/review.html` as one self-contained file: inline CSS, the journey grids as for an artifact, and each mock that passed the privacy check inlined in an iframe `srcdoc`. A mock that failed the check stays out, with its screen.
2. Tell the owner: "This session has no Artifact tool. Send review.html by email or chat, and paste the replies here."
3. Triage pasted comments the same way.
