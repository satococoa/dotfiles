This directory contains local agent skills managed by this dotfiles repository.

Each skill should live at:

```text
.agents/skills/<skill-name>/SKILL.md
```

`setup.sh` and `update.sh` link each skill into `~/.agents/skills/<skill-name>`.

Use `$<skill-name>` when referring to another skill. Do not reference Codex
plugin cache paths or system skill paths directly; those locations are
implementation details and can change between machines or updates.
