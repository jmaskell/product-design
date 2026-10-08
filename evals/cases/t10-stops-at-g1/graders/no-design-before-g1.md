---
type: tool_used
tool: Write
input_match: '"file_path"\s*:\s*"[^"]*(?:docs/plans/shared-timeline/(?!(?:issue|journey)\.md")|design\.md|mocks/)'
min: 0
max: 0
arm: both
---
Before the owner confirms the problem, Write creates no file under docs/plans/shared-timeline/ other than issue.md or journey.md, and no design.md or mocks/ file under any path.
