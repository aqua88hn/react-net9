#!/usr/bin/env bash
set -euo pipefail

ROOT=$(git rev-parse --show-toplevel)
AGENT_MD="$ROOT/.github/agents/react-net10-tailwind.agent.md"

echo "Linting agent file: $AGENT_MD"

missing=0
for header in "## 1) Persona / System Prompt" "### Constraints" "## How to generate template (local)"; do
  if ! grep -qF "$header" "$AGENT_MD"; then
    echo "Missing header: $header"
    missing=$((missing+1))
  fi
done

if [ $missing -ne 0 ]; then
  echo "Agent lint failed: $missing missing headers"
  exit 2
fi

echo "Agent lint passed."
