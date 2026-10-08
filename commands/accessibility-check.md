---
name: accessibility-check
description: Runs the accessibility lens of product-design:reviewing-product-design on a file, route or plan folder. Checks against WCAG 2.2 AA and the persona spectrum, and reports findings as CRITICAL / SIGNIFICANT / MINOR / UNKNOWN.
tools: Read, Grep, Glob, Bash, Agent
---

Run the accessibility lens of the product-design:reviewing-product-design skill on the file, route or plan folder given as the argument. Use skills/reviewing-product-design/reviewer-prompt.md with LENS = Accessibility, as one fresh agent. When the argument is a file or route, it replaces the plan-folder list. Report the findings in the terminal. Write no file.
