# Agents Suite — react-net10 helpers

This folder contains a small suite of developer agents used to scaffold, implement, enforce and review features for the React + .NET project templates.

Purpose
- Provide a clear runbook for how the individual agent files interact.
- Standardize metadata and lifecycle so tooling (lint, CI) can validate agent files.

Lifecycle (recommended)
1. Architecture Review (`react-net10-architecture-review.agent.md`) — run for high-level design and feasibility.
2. Feature / Maintain (`react-net10-feature-maintain.agent.md`) — implements features or bug fixes following architecture guidance.
3. Code Steward (`react-net10-code-steward.agent.md`) — enforces style, runs auto-refactor in dry-run and creates fix PRs.
4. Scaffolding / Templates (`react-net10-tailwind.agent.md`) — used when generating new project scaffolds.

Runbook
- For a new feature request: run Architecture Review → Feature Maintain (implement) → Code Steward (format/lint) → final Architecture Review (optional) → create PR.
- For a scaffold request: run Scaffolding agent (Tailwind) which uses `scripts/create-template.sh`.

Requirements for each agent file
- A commented metadata block at top containing: `name`, `version`, `language`, `agent-suite-version`, `authoritative`.
- Sections required: Persona/System Prompt, Constraints, Examples/How to run, and a small set of allowed commands.

CI / Lint
- The repo includes `/.github/agent-lint.sh` to validate header presence and metadata keys. Keep the script up to date when adding agents.

If you want, I can also generate a `meta-agent.md` that orchestrates these agents automatically (prompts + order + failure handling).

---
Small note: files are intentionally short and explicit so they can be linted and validated by simple scripts.
