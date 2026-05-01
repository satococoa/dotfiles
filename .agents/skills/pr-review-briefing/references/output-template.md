# Output Template

Use this structure when a user asks for a full PR review briefing. Compress sections when the PR is small.

Write section prose and findings in Japanese by default. Keep code snippets, file paths, commands, identifiers, and source-language quotes unchanged.

## Target

- PR / branch / diff:
- Base:
- Head:
- Review scope:
- Sources checked:

## Visual Brief

Include the generated graphic-recording style image first when image generation is available.

Then add:

- 2-4 sentences explaining what the visual is showing
- a Mermaid fallback only when it helps reviewers inspect exact flow
- the image-generation prompt if the image could not be generated

For the graphic-recording prompt, include: review target, changed actors/modules, before/after flow, risk hotspots, labels to render, and a request for a clean whiteboard or hand-drawn technical style. Keep it factual and avoid decorative elements that imply unverified architecture.

## Findings

List confirmed review findings first, ordered by severity.

For each finding:

- title
- severity: blocker / high / medium / low
- lens: security / breaking-change / bug / domain / tests / operations / maintainability
- evidence: file and line, with a short snippet when useful
- impact
- suggested fix

If there are no confirmed findings, write: `No confirmed blocking findings from the reviewed diff.`

## Code Tour

For each stop:

````markdown
### 1. Short Stop Name

File: `path/to/file.ts`
Why it matters: ...

```ts
small snippet
```

Change summary: ...
Reviewer note: ...
````

## Review Lenses

Summarize each lens:

- Security:
- Breaking changes:
- Suspected bugs:
- Domain knowledge:
- Tests:
- Operations:
- Maintainability:

## Open Questions

Only include questions that would change the review decision or implementation direction.

## Suggested Follow-Ups

Include focused next steps such as tests to add, owners to ask, live checks to run, or docs/runbooks to update.
