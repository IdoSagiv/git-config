#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
TIMESTAMP="$(date +%Y%m%d%H%M%S)"

# ── Uninstall ────────────────────────────────────────────────────────────────
if [[ "${1:-}" == "--uninstall" ]]; then
    echo "Uninstalling git-config..."

    for target in ~/.gitconfig ~/.config/git/ignore; do
        if [[ -L "$target" ]]; then
            rm -v "$target"
            # Restore most recent backup if one exists
            backup="$(ls -1t "${target}.bak."* 2>/dev/null | head -1 || true)"
            if [[ -n "$backup" ]]; then
                mv -v "$backup" "$target"
            fi
        fi
    done

    echo "Done."
    exit 0
fi

# ── Install ──────────────────────────────────────────────────────────────────
echo "Installing git-config from $REPO_DIR ..."

# Back up and symlink ~/.gitconfig
if [[ -e ~/.gitconfig && ! -L ~/.gitconfig ]]; then
    mv -v ~/.gitconfig ~/.gitconfig.bak."$TIMESTAMP"
fi
ln -sfv "$REPO_DIR/gitconfig" ~/.gitconfig

# Back up and symlink global gitignore
mkdir -p ~/.config/git
if [[ -e ~/.config/git/ignore && ! -L ~/.config/git/ignore ]]; then
    mv -v ~/.config/git/ignore ~/.config/git/ignore.bak."$TIMESTAMP"
fi
ln -sfv "$REPO_DIR/gitignore_global" ~/.config/git/ignore

echo ""
echo "Done! Git config is now symlinked."
echo "  ~/.gitconfig -> $REPO_DIR/gitconfig"
echo "  ~/.config/git/ignore -> $REPO_DIR/gitignore_global"
