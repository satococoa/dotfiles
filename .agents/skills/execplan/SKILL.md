---
name: execplan
description: Create, maintain, and execute self-contained ExecPlan documents for complex Codex work. Use when the user explicitly asks for an ExecPlan, PLANS.md, execution plan, multi-hour implementation plan, large feature, significant refactor, architecture migration, risky cross-module change, or a plan that must survive context compaction or handoff.
---

# ExecPlan

Use this skill to turn complex repository work into a living, self-contained plan that another agent or a novice contributor can execute from the current working tree alone.

## Workflow

1. Decide whether an ExecPlan is warranted. Use it for work with substantial unknowns, multiple milestones, broad code ownership, risky migrations, or explicit user requests. For small local fixes, proceed normally.
2. Look for project instructions first: `AGENTS.md`, `.agent/PLANS.md`, `PLANS.md`, `.agents/PLANS.md`, or any user-provided plan standard. If found, follow the repository version over this skill's fallback template.
3. If the repository has no plan standard, read `references/PLANS.md` and use it as the plan contract.
4. Create or update one plan file in the repository when the user wants a durable artifact. Prefer a path already used by the repo; otherwise use `plans/<short-task-name>.md` or `.agent/plans/<short-task-name>.md` when that convention exists.
5. Keep the plan self-contained. Include repository-relative file paths, commands, expected observations, assumptions, definitions of non-obvious terms, and validation criteria.
6. During implementation, update the plan at every meaningful stopping point. Keep `Progress`, `Surprises & Discoveries`, `Decision Log`, and `Outcomes & Retrospective` current.
7. Continue from milestone to milestone without asking for generic "next steps" unless the user needs to make a product or safety decision.
8. At completion, record validation evidence and final outcome in the plan, then summarize the result to the user.

## Authoring Rules

- Write for a reader with no prior conversation context.
- Explain the user-visible purpose before implementation details.
- Resolve ambiguity inside the plan and record the rationale.
- Prefer prose for design and milestone sections; use checkboxes only for `Progress`.
- Make every milestone independently verifiable.
- State exact commands with working directories and expected success signals.
- Include recovery and retry guidance for risky or stateful operations.
- Do not point to external docs as required knowledge; summarize any required knowledge inside the plan.

## Implementation Rules

- Re-read the plan before starting a new milestone.
- Keep code edits aligned with the plan, and revise the plan when reality differs.
- Capture concise evidence from tests, logs, diffs, or manual checks.
- If a prototype or spike is needed, label it clearly, make it additive, and define the criteria for keeping or discarding it.
- When context may be compacted or another agent may resume the task, make sure the plan alone explains the current state and next action.

## Reference

- `references/PLANS.md`: fallback ExecPlan contract and skeleton, adapted from OpenAI's "Using PLANS.md for multi-hour problem solving" cookbook article.
