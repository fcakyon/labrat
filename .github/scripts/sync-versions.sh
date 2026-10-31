#!/bin/bash
# Copy the version from plugin/.claude-plugin/plugin.json (source of truth) to
# every other manifest and marketplace entry. Bump there, then run:
#   bash .github/scripts/sync-versions.sh

set -euo pipefail

python3 - "$(cd "$(dirname "$0")/../.." && pwd)" << 'PYEOF'
import json
import re
import sys
from pathlib import Path

repo = Path(sys.argv[1])
version = json.loads((repo / "plugin/.claude-plugin/plugin.json").read_text())["version"]
for rel in [
    "plugin/.codex-plugin/plugin.json",
    "plugin/.cursor-plugin/plugin.json",
    "plugin/gemini-extension.json",
    ".claude-plugin/marketplace.json",
    ".cursor-plugin/marketplace.json",
]:
    path = repo / rel
    text = path.read_text()
    new = re.sub(r'("version"\s*:\s*)"[^"]*"', lambda m: f'{m.group(1)}"{version}"', text)
    json.loads(new)
    if new != text:
        path.write_text(new)
        print(f"{rel}: version={version}")
PYEOF
