#!/usr/bin/env bash
set -eu

# Resolve repository root from docs/scripts/
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

# Clean up generated documentation site and synced content
rm -rf site
rm -rf docs/code_lists/
rm -rf docs/projects/