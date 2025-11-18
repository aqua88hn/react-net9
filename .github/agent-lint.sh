#!/usr/bin/env bash
set -euo pipefail

ROOT=$(git rev-parse --show-toplevel)
AGENTS_DIR="$ROOT/.github/agents"

echo "Linting agent files in: $AGENTS_DIR"

overall_missing=0
for AGENT_MD in "$AGENTS_DIR"/*.md; do
  base=$(basename "$AGENT_MD")
  # skip README
  if [ "$base" = "README.md" ]; then
    echo "Skipping $base"
    continue
  fi

  echo "Checking $base"
  missing=0

  # Check commented metadata block in top 40 lines for required keys
  header_block=$(sed -n '1,40p' "$AGENT_MD" || true)
  for key in "name:" "version:" "language:" "agent-suite-version:" "authoritative:"; do
    if ! printf '%s\n' "$header_block" | grep -qF "$key"; then
      echo "$base: Missing metadata key in header: $key"
      missing=$((missing+1))
    fi
  done

  # Basic header checks: require a top-level numbered section (## 1) to ensure structure
  if ! grep -qE "^##\s*1" "$AGENT_MD"; then
    echo "$base: Missing top-level section header '## 1'"
    missing=$((missing+1))
  fi

  if [ $missing -ne 0 ]; then
    overall_missing=$((overall_missing+missing))
  else
    echo "$base: OK"
  fi
done

if [ $overall_missing -ne 0 ]; then
  echo "Agent lint failed: $overall_missing missing items across agent files"
  exit 2
fi

echo "Agent lint passed for all checked agent files."
