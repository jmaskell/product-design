---
name: t22g-compliance
runs: 5
max_turns: 6
plugins: ["../../.."]
---

Use the writing-ui-copy skill. Write the strings for this screen in a lettings app, and reply with them as a list of `element: string`.

Screen: a tenant's repair detail page.
- Page heading
- The repair's status
- Button to withdraw the repair (permanent)
- Confirmation shown before withdrawing
- Button to add a photo
- Error when a photo upload fails because the file is over 10MB
- Message shown when the repair has no updates yet
