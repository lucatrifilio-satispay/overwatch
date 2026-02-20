#!/bin/bash
# overwatch installer - symlinks binaries and configures Claude Code hook

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="${HOME}/.local/bin"

echo "Installing overwatch..."

# Ensure bin directory exists
mkdir -p "$BIN_DIR"

# Symlink binaries
ln -sf "${SCRIPT_DIR}/bin/overwatch" "${BIN_DIR}/overwatch"
ln -sf "${SCRIPT_DIR}/bin/overwatch-tmux" "${BIN_DIR}/overwatch-tmux"
ln -sf "${SCRIPT_DIR}/bin/overwatch-notify" "${BIN_DIR}/overwatch-notify"

echo "  Linked: overwatch -> ${BIN_DIR}/overwatch"
echo "  Linked: overwatch-tmux -> ${BIN_DIR}/overwatch-tmux"
echo "  Linked: overwatch-notify -> ${BIN_DIR}/overwatch-notify"

# Check dependencies
if ! command -v vim &> /dev/null; then
    echo "  WARNING: vim not found"
fi
if ! command -v git &> /dev/null; then
    echo "  WARNING: git not found"
fi
if ! command -v tmux &> /dev/null; then
    echo "  WARNING: tmux not found (required for auto-launch)"
fi

echo ""
echo "Done! Make sure ~/.local/bin is in your PATH."
echo ""
echo "To enable auto-launch with Claude Code, add this hook to ~/.claude/settings.json:"
echo '  "hooks": {'
echo '    "SessionStart": [{'
echo '      "matcher": "startup",'
echo '      "hooks": [{"type": "command", "command": "overwatch-tmux", "timeout": 10, "async": true}]'
echo '    }]'
echo '  }'
