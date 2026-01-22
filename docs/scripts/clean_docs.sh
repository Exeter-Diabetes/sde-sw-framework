#!/usr/bin/env bash
set -euo pipefail

# Resolve repository root from docs/scripts/
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

rm -rf site
