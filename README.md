# OnCalls Documentation

Planning, architecture, and workflow documentation for the OnCalls medical scheduling platform.

## Repository Structure

```
oncalls-docs/
├── _bmad/                    # BMAD Framework (agents, workflows, templates)
│   ├── bmm/                  # BMad Method module
│   ├── bmb/                  # BMAD Builder module
│   └── core/                 # Core framework
├── _bmad-output/             # Generated documents
│   ├── prd.md                # Product Requirements Document
│   ├── research-oncalls.md   # Domain research
│   └── *.md                  # Other artifacts
├── .claude/                  # Claude Code commands
│   └── commands/bmad/        # BMAD slash commands
├── docs/                     # Operational documentation
│   └── schedule-audit-log.md # Production change log
└── CHECKPOINT-*.md           # Session checkpoints
```

## Related Repositories

| Repo | Purpose |
|------|---------|
| [oncalls25_react_Back](https://github.com/jacobmr/oncalls25_react_Back) | Production/Staging code (Frontend + Backend) |
| **oncalls-docs** (this repo) | Planning & documentation |

## Current Status

- **PRD Progress:** Step 7 of 11 complete
- **Phase:** Planning (BMM Workflow)
- **Next:** Complete PRD, then Architecture

## Using This Repo

For BMAD workflows, run Claude Code from this directory:

```bash
cd ~/dev/oncalls-docs
claude
# Then use /bmad:bmm:workflows:create-prd to continue
```
