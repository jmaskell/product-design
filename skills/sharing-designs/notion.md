# Notion target

Needs the Notion MCP tools: notion-fetch, notion-create-pages, notion-update-page, notion-get-users, notion-create-file-upload, notion-get-comments, notion-create-comment.

## Database

1. Read the database with notion-fetch and the `Review space` URL.
2. The page needs these properties: Name (title), Status (select: Problem review, Design review, Approved, Filed, Superseded), Size (select: Small, Medium, Large), Reviewers (people), Revision (number), Plan folder (text).
3. Ask the owner before you add a missing property. Without an answer, publish with the properties that exist.
4. Set Status to Approved only after the owner approves in this session.

## People

Keep docs/product/people.md, from templates/people.md two levels above this skill's directory. Roles come from docs/product/actors.md.

1. Collect every name in "Check with" and "Who answers".
2. Look up each name that people.md does not hold with notion-get-users and the name as the query.
3. If people.md holds the name but the plan gives a role that the row does not hold, show the owner the match again.
4. Show the owner one list: each name with its match, "no match", or "<n> matches". Save only the matches the owner confirms. Never choose between two people with one name.
5. Write a person with no Notion account as plain text, then "(not in Notion: share another way)".

## Page

1. Create the page with notion-create-pages: the parent is the database, with the properties set. Status is Problem review before screens exist, else Design review.
2. Mention each person in "What we need from you" and on each question they answer. Mention only people with an open question in this revision. Put the same people in Reviewers.
3. Make each table row, screen and question its own block, so a comment attaches to it.
4. If the content is too large for one call, create the page with the Summary, then add each section with notion-update-page: insert after the existing content, and never replace the content.

`Unverified:` the user-mention markup that notion-create-pages accepts. Read it from the tool description.

## Screens

1. Take one screenshot of each mock state with the session's browser tool.
2. Upload each one with notion-create-file-upload, and put its suggested markdown in the Screens section.
3. Caption each image with the mock's path in the plan folder.
4. Without a browser tool, list each screen with its rationale and say that no screenshots were taken.

## Revisions

Never rewrite a published page: a rewrite deletes blocks and their comments.
1. Triage the comments first.
2. Create the next revision as a new row with Revision n+1.
3. Set the old row's Status to Superseded.
4. Link each row to the other. Add the link with notion-update-page: insert after the existing content, and never replace the content.

## Comments

Read with notion-get-comments on the page, with block-level and resolved discussions. Also read every earlier row named in the `Review page:` lines that has an open or new discussion. Reply there. Reply in each discussion with notion-create-comment. Put any discussion you cannot reply in into your message to the owner.
