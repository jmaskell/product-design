# Notion target

Needs the Notion MCP tools: notion-fetch, notion-create-database, notion-update-data-source, notion-create-pages, notion-update-page, notion-get-users, notion-create-file-upload, notion-get-comments, notion-create-comment.

## Database

`Review space: notion <url>` names a Notion page or a Notion database. Read the URL with notion-fetch to find out which.

The page needs these properties: Name (title), Status (select: Problem review, Design review, Superseded), Size (select: Small, Medium, Large), Reviewers (people), Revision (number), Plan folder (text).

A page URL:
1. On the first publish, create a database named "Design review" in that page with notion-create-database. Give it all the properties above. Create the review page in the new database in this same run.
2. Tell the owner the new database URL. Ask them to put it in the project metadata: `Review space: notion <database URL>`.
3. On a later run, if the line still names the page, use the "Design review" database in that page. Do not create a second one.

A database URL:
1. Use that database.
2. Ask the owner before you add a missing property, then add it with notion-update-data-source.
3. If you cannot add a property, tell the owner which one is missing. Offer to create a fresh "Design review" database, and ask for a page to put it in.
4. Without an answer, publish with the properties that exist.

`Unverified:` the property schema that notion-create-database accepts. Read it from the tool description.

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
3. Make each screen and each question its own block, so a comment attaches to it. Write each journey grid as a Notion table. A comment on a grid cannot point to one cell. It anchors to a whole row, or to the page when the text it quotes occurs more than once. Under each grid, write: "To comment on this grid, quote the stage and the person you mean."
4. If the content is too large for one call, create the page with the Summary. Then add each section as Adding content says.

Confirmed by the owner's run (2026-10-08): mentions in notion-create-pages notify each person. Use the mention form the tool description gives.

## Adding content

Add to a published page only with notion-update-page `update_content`. Its `old_str` must match exactly one place on the page.
1. Choose as `old_str` a line that occurs once on the page.
2. Make `new_str` that same line, followed by the new content.
3. Never use `replace_content` on a published page. It deletes blocks and their comments.

`Unverified:` a search-and-replace keeps the comments on the matched block.

## Screens

Screenshot uploads are slow. Publish the text first, so that reviewers can start.
1. In the first publish, put every section on the page. Give each screen its rationale and the note "Screenshot of <screen> below when uploaded." Each note names its screen, so that the line occurs once.
2. Take one screenshot of each screen, of its main state, with the session's browser tool. Set the viewport first: 1024×768 for a desktop mock, 390×844 for a phone mock. Capture the mock's content element, not the full scrolling page.
3. Scale each image wider than 1000 px down to 1000 px wide. Keep each file under about 300 KB. Use the image tool the session has, for example sips or ImageMagick. If there is none, tell the owner the images are full size.
4. Upload each one with notion-create-file-upload.
5. Add each image as Adding content says. The `old_str` is that screen's note line.
6. Caption each image with the mock's path in the plan folder. Under the image, list the other states of that screen as text, from design.md.
7. Without a browser tool, write "No screenshot: no browser tool in this session." in place of the note. List the screen's states as text, from design.md.

## Revisions

Never rewrite a published page: a rewrite deletes blocks and their comments.
1. Triage the comments first.
2. Create the next revision as a new row with Revision n+1.
3. Set the old row's Status to Superseded.
4. Link each row to the other. Add the link to the old row as Adding content says.

## Comments

Read with notion-get-comments on the page, with block-level and resolved discussions. Also read the comments on every earlier row named in the `Review page:` lines. Skip a discussion whose last comment is your reply. Triage only the comments after it. Match a page-level comment to its grid row by the stage and the person it quotes. Reply in each discussion, on any row, with notion-create-comment. Put any discussion you cannot reply in into your message to the owner.
