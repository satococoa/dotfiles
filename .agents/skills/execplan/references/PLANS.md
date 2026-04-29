# Codex Execution Plans

This reference is a compact fallback contract for ExecPlans. Prefer a repository's own `PLANS.md` or `AGENTS.md` instructions when present.

Source inspiration: OpenAI cookbook article "Using PLANS.md for multi-hour problem solving" at https://developers.openai.com/cookbook/articles/codex_exec_plans.

## Core Contract

An ExecPlan is a living design and implementation document for a coding agent. It must be self-contained enough that a reader with only the current working tree and the plan can finish the work.

Every ExecPlan must:

- Explain the purpose and user-visible outcome.
- Define non-obvious terms in plain language.
- Name relevant files, modules, commands, and interfaces explicitly.
- Describe safe, idempotent steps where possible.
- Include validation that proves behavior, not just compilation.
- Stay updated as work proceeds.
- Preserve enough context for handoff after compaction or interruption.

## Required Sections

Use these sections unless the repository's plan standard says otherwise.

```md
# <Short, action-oriented title>

This ExecPlan is a living document. Keep `Progress`, `Surprises & Discoveries`, `Decision Log`, and `Outcomes & Retrospective` current as work proceeds.

If this repository has a `PLANS.md`, reference its repository-relative path here and state that this plan follows it.

## Purpose / Big Picture

Explain what someone can do after this change that they could not do before. Describe how they can observe the behavior working.

## Progress

- [x] (YYYY-MM-DD HH:MMZ) Completed step with concrete evidence.
- [ ] Remaining step with concrete acceptance.
- [ ] Partially completed step, including what is done and what remains.

## Surprises & Discoveries

- Observation: Describe an unexpected behavior, constraint, bug, or useful finding.
  Evidence: Include a concise command, output excerpt, trace, or file reference.

## Decision Log

- Decision: State the decision.
  Rationale: Explain why this option was chosen.
  Date/Author: YYYY-MM-DD / Codex

## Outcomes & Retrospective

Summarize what was delivered, what remains, and what was learned. Update at major milestones and completion.

## Context and Orientation

Describe the relevant current repository state as if the reader is new. Name files and modules by repository-relative path. Define terms when first used.

## Plan of Work

Describe the sequence of edits and additions in prose. For each edit, name the file, function, module, or command surface involved.

## Concrete Steps

State exact commands and working directories. Include concise expected output or success signals when useful.

## Validation and Acceptance

Describe tests, manual checks, service startup, CLI invocations, HTTP requests, or other observations that prove the change works. Explain how to interpret success and failure.

## Idempotence and Recovery

Explain which steps can be repeated safely. For risky steps, describe rollback, retry, backup, or cleanup behavior.

## Artifacts and Notes

Include focused transcripts, diffs, logs, examples, or interface sketches that help the next reader continue.

## Interfaces and Dependencies

Name important libraries, services, modules, types, traits, functions, endpoints, commands, or schemas that the final implementation must provide or use.
```

## Milestone Guidance

Milestones should tell a short story: goal, work, result, proof. Each milestone should leave the repo in a verifiable state.

Use prototypes when they reduce risk. Keep prototypes additive, state how to run them, and define the criteria for promoting or deleting them.

Parallel implementations are acceptable during migrations when they keep validation possible. Explain how both paths are tested and how the old path will be retired.

## Revision Guidance

When updating an ExecPlan:

- Reflect the change in every affected section.
- Add a `Decision Log` entry for material direction changes.
- Add `Surprises & Discoveries` entries for unexpected findings with evidence.
- Update `Progress` before stopping.
- Add or update `Outcomes & Retrospective` at major milestones and completion.
