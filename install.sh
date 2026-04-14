#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
TIMESTAMP="$(date +%Y%m%d%H%M%S)"

# ── Install dependencies ────────────────────────────────────────────────────
install_deps() {
    echo "Checking dependencies..."
    local installed=() skipped=()

    # delta
    if command -v delta &>/dev/null; then
        skipped+=("delta (already installed)")
    else
        echo "Installing delta..."
        local delta_version="0.18.2"
        local delta_deb="git-delta_${delta_version}_amd64.deb"
        curl -fsSL "https://github.com/dandavison/delta/releases/download/${delta_version}/${delta_deb}" -o "/tmp/${delta_deb}"
        sudo dpkg -i "/tmp/${delta_deb}"
        rm -f "/tmp/${delta_deb}"
        installed+=("delta")
    fi

    # gh (GitHub CLI)
    if command -v gh &>/dev/null; then
        skipped+=("gh (already installed)")
    else
        echo "Installing gh..."
        sudo mkdir -p -m 755 /etc/apt/keyrings
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null
        sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli-stable.list >/dev/null
        sudo apt-get update -qq && sudo apt-get install -y -qq gh
        installed+=("gh")
    fi

    echo ""
    if [ ${#installed[@]} -gt 0 ]; then
        echo "Installed: ${installed[*]}"
    fi
    if [ ${#skipped[@]} -gt 0 ]; then
        echo "Skipped:   ${skipped[*]}"
    fi
    echo ""
}

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

# Install dependencies if requested
if [[ "${1:-}" == "--with-deps" ]]; then
    install_deps
fi

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
