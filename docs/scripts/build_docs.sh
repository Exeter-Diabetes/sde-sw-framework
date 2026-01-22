#!/usr/bin/env bash
set -euo pipefail

# Resolve repository root from docs/scripts/
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

DOCS_DIR="$ROOT_DIR/docs"

# Ensure index.md in docs/ matches the top-level README
python3 docs/scripts/sync_readme_to_index.py

# Sync markdown content for MkDocs into docs/
rsync -a --delete "code_lists/" "$DOCS_DIR/code_lists/"
rsync -a --delete "projects/" "$DOCS_DIR/projects/"

# Build the MkDocs site (defaults to ./site as a sibling of mkdocs.yml)
mkdocs build
