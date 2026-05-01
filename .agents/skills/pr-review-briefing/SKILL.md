---
name: pr-review-briefing
description: Create a reviewer-friendly pull request briefing from a diff, branch, or PR URL. Use when Codex needs to understand and explain code changes with a diagram or graphic-recording style visual, produce a code tour with concrete snippets, and perform a risk-focused review covering security, breaking changes, suspected bugs, domain-knowledge concerns, tests, operations, and maintainability.
---

# PR Review Briefing

## Overview

Produce a compact review package that helps humans understand a PR before deciding whether to approve, request changes, or ask domain questions.

## Language

Write the final review briefing and review comments in Japanese by default. If the PR body, repository convention, or user request specifies a language, follow that language. Keep code identifiers, file paths, commands, and quoted snippets in their original language.

## Workflow

1. Identify the review target: PR URL/number, branch range, local diff, or changed files. If unclear, infer from the current repo state and state the exact base/head used.
2. Read the diff and the surrounding code needed to understand behavior. Prefer `gh pr diff`, `git diff`, `git show`, `rg`, and focused file reads.
3. For every major output, inspect the relevant surrounding code first:
   - visual brief: callers, callees, module boundaries, persistence, external services, and feature flags/config that shape the flow
   - code tour: definitions and use sites for changed functions, components, types, schemas, queries, and public interfaces
   - review findings: tests, migrations, authorization boundaries, error handling, deployment/runtime assumptions, and existing patterns near the changed code
   Do not base conclusions only on the patch when surrounding code is available.
4. Build a change model:
   - user-facing behavior
   - touched modules and ownership boundaries
   - data flow, control flow, external calls, persistence, and config changes
   - tests added, changed, or missing
5. Use subagents when available and useful:
   - Delegate independent review lenses such as security, breaking changes, domain assumptions, or test coverage.
   - Give each subagent the PR/diff target, the specific lens, and explicit permission to inspect surrounding code. Ask for findings with file/line evidence.
   - Keep synthesis local; verify any high-impact finding before presenting it.
6. Create the outputs in this order:
   - graphic-recording style visual brief
   - code tour
   - review findings
   - additional review lenses or suggested follow-ups

## Visual Brief

Create a graphic-recording style image that makes the change easy to understand at a glance. Use image generation when available, and include the generated image in the review output. If image generation is unavailable, state that limitation and produce both a Mermaid diagram and an image-generation prompt the user can reuse.

Include these elements:

- the main actors or entry points
- before/after behavior when relevant
- changed modules or services
- data movement and side effects
- risk hotspots marked visually

Write the image prompt from the inspected surrounding code, not just the patch. Include concise labels for modules, flows, and risk hotspots. Keep the visual factual; do not invent architecture outside the diff and surrounding code. If a relationship is inferred, label it as inferred in the textual explanation.

Use this image style unless the user asks otherwise:

- clean whiteboard or notebook page
- hand-drawn technical diagram / graphic recording
- limited color accents for changed paths and risk hotspots
- readable labels in Japanese when the review output language is Japanese
- no decorative elements that imply unverified systems or behavior

## Code Tour

Walk the reviewer through the change in dependency or execution order, not file-name order when those differ.

For each stop, include:

- file path and function/component/class name
- why this stop matters
- a short code snippet, usually 5-20 lines
- what changed semantically
- what to inspect next

Avoid dumping whole files. Prefer snippets that show the decision point, interface boundary, query, migration, permission check, or side effect.

## Review Lenses

Review from these lenses and keep findings evidence-based:

- **Security**: authz/authn, input validation, secrets, injection, SSRF, path traversal, data exposure, tenancy boundaries, logging of sensitive data, dependency risk.
- **Breaking changes**: API/schema/contract changes, migrations, feature flags, backwards compatibility, deploy order, old clients, configuration defaults.
- **Suspected bugs**: incorrect state transitions, null/undefined handling, race conditions, idempotency, retries, error handling, pagination, time zones, partial failure, resource cleanup.
- **Domain knowledge**: business rules, permissions, customer/environment differences, billing/accounting semantics, operational invariants, legal/compliance assumptions.
- **Tests**: coverage of changed behavior, regression tests for risky paths, fixture realism, missing negative cases, flaky or over-broad tests.
- **Operations**: observability, alerts, logs, dashboards, rollback, migration safety, queue/backfill behavior, performance and cost impact.
- **Maintainability**: unnecessary abstractions, duplicated logic, unclear ownership boundaries, hard-to-review coupling, type-safety gaps.

Findings should lead. Use severity and confidence when helpful. If no concrete issue is found for a lens, say so briefly and mention remaining uncertainty.

## Output Format

For detailed structure, read `references/output-template.md` when preparing the final response or a reusable review artifact.

Keep the final answer review-ready:

- State the exact target reviewed.
- Put actionable findings before summaries.
- Separate confirmed findings from questions or assumptions.
- Include code links and snippets.
- Include the visual artifact or Mermaid source.
- Do not claim a live behavior, CI result, or production state without checking the real source.
