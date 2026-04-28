---
name: pr-babysitting
description: Continuously babysit an open GitHub pull request by creating a 10-minute heartbeat automation in the current thread, handling AI review comments, surfacing human review comments for user decisions, fixing actionable CI failures, resolving merge conflicts, and stopping once AI feedback appears complete and the PR is mergeable. Use when Codex should keep checking a PR until it is ready to merge instead of doing a one-off review pass.
---

# PR Babysitting

## Overview

Create a thread heartbeat automation that wakes up every 10 minutes and keeps a pull request moving toward mergeability.

Treat invocation of this skill as explicit approval to perform the following write actions on the target PR when they are low-risk and well-justified: edit code, run focused local validation, commit, push, reply to AI review threads, resolve AI review threads, and update the automation lifecycle.

## Inputs

Resolve the target PR from one of:

- A PR URL or PR number supplied by the user
- The current branch PR when the user is already inside the repository

If the target repository or PR cannot be resolved safely, stop and ask for the missing identifier.

## Automation Setup

Create a heartbeat automation attached to the current thread.

- Use `kind="heartbeat"` and `destination="thread"`.
- Use a 10-minute schedule.
- Name it with the repository and PR number when available, for example `PR Babysit #123`.
- Keep the automation prompt focused on the recurring task itself, not the schedule.

Before making any mergeability or completion decision, refresh state from the remote source of truth.

- Fetch the latest remote branch state for both the PR branch and the base branch.
- Re-read current PR metadata, review threads, and check status from GitHub after the refresh.
- If the run pushes new commits, refresh PR metadata again before deciding whether the PR is ready.
- If mergeability information looks stale, missing, or inconsistent, make the conservative choice and keep the automation running.

Use a prompt equivalent to:

1. Refresh remote branch state and PR metadata, then inspect the target PR for unresolved AI review threads, new human review comments, failing CI, and merge conflicts.
2. If an AI review comment is clearly worth addressing, handle it automatically, then reply on the thread and resolve it.
3. If an AI review comment is clearly not worth addressing, reply with the rationale and resolve it.
4. If it is not clear whether the comment should be addressed, explain the point being raised, include a recommended response or fix, and ask the user to decide.
5. If a human review comment arrives, summarize it in this thread and ask the user what to do. Do not auto-resolve human comments.
6. If GitHub Actions CI is failing, investigate and apply a focused fix.
7. If the PR has merge conflicts, resolve straightforward conflicts and push the result; if the conflict resolution is ambiguous, ask the user.
8. Stop the automation once the finish criteria in this skill are satisfied, or if the PR is merged or closed.

## Review Handling

### AI Comments

Use `$github:gh-address-comments` for thread-aware review inspection and replies.

For this skill, `Reply` has a strict meaning: post a reply inside the existing GitHub review thread that raised the comment. It does not mean creating a new review, a top-level PR comment, or a standalone review comment.

Write guardrails:

- Reply only to the existing review thread that owns the comment.
- Do not submit a new review as a substitute for a thread reply.
- Do not create a top-level PR comment as a substitute for a thread reply.
- Do not create a standalone review comment detached from the existing thread.
- Resolve a thread only after the thread reply has been posted successfully.
- If thread-aware identifiers or reply targeting are unavailable, do not guess; report the blocker in this thread and leave the GitHub thread untouched.

Classify each AI review thread into exactly one of these buckets:

- Clearly address: the comment should be handled now.
- Clearly no action: the comment does not merit a code change or further escalation.
- Needs user decision: it is not obvious whether or how to respond.

Treat an AI review thread as clearly addressable when the answer to whether it should be addressed is obvious. Typical examples are concrete correctness fixes, obvious missing tests, straightforward lint or typing fixes, and narrow code-local changes whose intent is unambiguous and whose validation path is clear.

Treat an AI review thread as clearly no-action when the comment is based on a misread, is already satisfied by the existing code, is outside the intended scope of the PR, or suggests a change that would be net-worse while the reason is easy to explain briefly and concretely.

Treat an AI review thread as user-decision-required when whether to act is not obvious. Typical examples are comments that change product behavior, request a broader refactor, depend on unclear repository conventions, conflict with other feedback, or have multiple reasonable responses.

Strong default:

- Auto-handle comments about lint, formatting, typing, obvious correctness bugs, clear edge-case handling, and obviously missing tests for existing intended behavior.
- Auto-decline comments that are plainly incorrect, already covered by the diff or existing code, or clearly out of scope for the PR, as long as the rationale can be explained crisply.
- Ask the user about comments that would change product behavior, API contracts, UX copy, schema choices, public interfaces, architectural boundaries, or repository conventions that are not already clearly established in the diff.
- If the smallest honest summary is "this is partly a product or design choice," ask the user.
- If there are multiple plausible fixes and the skill cannot strongly justify one as the clear intent-preserving option, ask the user.
- If there are multiple plausible reasons to decline and the tradeoff matters, ask the user instead of choosing the framing unilaterally.

When the thread is clearly addressable:

1. Implement the change.
2. Run the smallest relevant local verification.
3. Commit and push only the changes needed for that thread or tightly related threads.
4. Reply inside the existing review thread with a short explanation of what changed.
5. Resolve the review thread after the thread reply succeeds.

When the thread is clearly no-action:

1. Reply inside the existing review thread with a short explanation of why no code change is needed.
2. Resolve the review thread after the thread reply succeeds.

When whether to address the AI feedback is not obvious:

1. Explain what the comment is pointing out in plain language.
2. Provide a recommended action, such as reply-only, a concrete code change, or intentional no-action.
3. Ask the user for a decision.
4. Leave the review thread unresolved until the user decides.

### Human Comments

Treat any human review comment as user-decision-required by default.

1. Summarize the request and the likely implementation options in this thread.
2. Ask the user what they want to do.
3. Do not reply on GitHub or resolve the human thread unless the user explicitly asks for that write.

## CI Handling

Use `$github:gh-fix-ci` to inspect failing GitHub Actions checks.

For this skill, treat the user's request to babysit the PR as approval to implement straightforward CI fixes that are directly tied to the failing checks.

Workflow:

1. Inspect failing GitHub Actions checks and identify the narrowest credible root cause.
2. If the failure is external, flaky, or unrelated to the branch diff, report that in this thread instead of forcing a speculative code change.
3. If the fix is clear and low-risk, implement it, run the best matching local check, commit, and push.
4. If the fix requires product judgment or broad refactoring, ask the user before proceeding.

## Conflict Handling

If the PR branch is conflicted with its base branch:

1. Update the branch using the repository's existing workflow.
2. Resolve straightforward textual conflicts locally.
3. Run focused validation for the touched areas.
4. Push the conflict resolution.

If the conflict requires semantic judgment, ask the user before choosing a side or rewriting behavior.

Always base conflict and mergeability decisions on freshly refreshed remote state, not on local branch state alone.

## Finish Criteria

Consider the babysitting task complete only when all of the following are true:

- The PR is open
- The PR is mergeable and not conflicted
- There are no failing required checks
- There are no unresolved AI-authored review threads that still need action
- No new AI review comments have appeared since the latest push, and the latest push has been idle for at least one full automation interval
- No user decision is currently blocking progress
- The mergeable judgment was confirmed from freshly refreshed PR metadata during the current run

Interpret "AI feedback appears complete" conservatively. If there is a pending AI review, a very recent push, or uncertainty about whether more AI comments are still coming, keep the automation running.

Once the finish criteria are met:

1. Post a short status update in this thread summarizing why the PR now looks ready.
2. Delete the heartbeat automation so it does not keep waking up.

Also delete the automation if the PR is merged, closed, or the user cancels the babysitting request.

## Safeguards

- Avoid large opportunistic refactors while addressing review or CI items.
- Avoid bundling unrelated fixes into the same commit.
- Prefer small, traceable changes tied to a specific thread or failing check.
- Surface uncertainty instead of guessing when review comments conflict or lack enough context.
- If CLI authentication or repository access is missing, report the blocker in this thread and wait for the user.
