# git-config

My personal git configuration — delta side-by-side diffs, Catppuccin Mocha syntax theme, short aliases, and sane defaults.

![demo](demo.gif)

## Install

```sh
git clone https://github.com/IdoSagiv/git-config.git ~/git-config
cd ~/git-config
./install.sh
```

The installer symlinks config files into place.
Any existing `~/.gitconfig` or `~/.config/git/ignore` is backed up to `<file>.bak.<timestamp>`.

To also install dependencies (delta, gh):

```sh
./install.sh --with-deps
```

To remove:

```sh
./install.sh --uninstall
```

### Dependencies

- git
- [delta](https://github.com/dandavison/delta) (for enhanced diffs)
- [gh](https://cli.github.com/) (for GitHub credential helper)

## Aliases

| Alias | Expands to | What it does |
|---|---|---|
| `git st` | `status` | Short status |
| `git co` | `checkout` | Checkout |
| `git cod` | `checkout develop` | Jump to develop |
| `git nb <name>` | `checkout -b` | Create and switch to new branch |
| `git c` | `commit` | Commit |
| `git cam` | `commit -am` | Stage all tracked + commit with message |
| `git cb` | `rev-parse --abbrev-ref HEAD` | Print current branch name |
| `git cc` | `rev-parse HEAD` | Print current commit hash |
| `git cp` | `cherry-pick` | Cherry-pick |
| `git f` | `fetch` | Fetch |
| `git po` | `pull origin` | Pull from origin |
| `git pod` | `pull origin develop` | Pull develop from origin |
| `git pp` | `pull --prune` | Pull and prune deleted remote branches |
| `git proc` | `pull --rebase origin <current>` | Pull-rebase current branch from origin |
| `git pushu` | `push --set-upstream origin <current>` | Push and set upstream for current branch |
| `git uncommit` | `reset HEAD^` | Undo last commit (keep changes staged) |
| `git delete-branch` | `push origin --delete` | Delete a remote branch |

## Features

- **Delta pager** — all diffs and logs render through [delta](https://github.com/dandavison/delta) with side-by-side view, line numbers, and navigation
- **Catppuccin Mocha** syntax theme for diffs
- **diff3 conflict style** — merge conflicts show base, ours, and theirs
- **colorMoved** — moved lines in diffs are color-coded so renames stand out
- **autoSetupRemote** — `git push` automatically sets upstream on first push
- **Global gitignore** — project-local files (`.claude/settings.local.json`) excluded everywhere

## Files

| File | Purpose |
|---|---|
| `gitconfig` | Main config → symlinked to `~/.gitconfig` |
| `gitignore_global` | Global gitignore → symlinked to `~/.config/git/ignore` |
| `install.sh` | Installer / uninstaller |
| `demo.tape` | VHS script — run `vhs demo.tape` to regenerate `demo.gif` |

## Customizing

Edit `gitconfig` in the repo — the installer symlinks it, so changes take effect immediately.
