---
type: tool_used
tool: Write
input_match: '(?:docs/product/journeys/[^"]+\.md"[\s\S]*Code:[^\\]*src/|Code:[^\\]*src/[\s\S]*docs/product/journeys/[^"]+\.md")'
min: 1
arm: both
---
At least one canonical journey is written with a Code line that names a source path.
