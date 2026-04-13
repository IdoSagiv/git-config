# Generates demo.gif. Install vhs (https://github.com/charmbracelet/vhs)
# then run:   vhs demo.tape
# (vhs bundles ttyd + ffmpeg, so no other deps needed.)

Output demo.gif

Set Shell        "bash"
Set FontSize     16
Set Width        1100
Set Height       680
Set Theme        "Catppuccin Mocha"
Set Padding      20
Set TypingSpeed  50ms
Set PlaybackSpeed 1.0

# === Setup (hidden) ==========================================================
# Create a temp git repo so we can show real git output without leaking info.
Hide
Type "cat > /tmp/vhsdemo-rc <<'EOF'" Enter
Type "PS1='\[\033[1;36m\]❯\[\033[0m\] '" Enter
Type "unset PROMPT_COMMAND" Enter
Type "EOF" Enter
Type "bash --rcfile /tmp/vhsdemo-rc -i" Enter
Sleep 300ms
Type "export GIT_CONFIG_GLOBAL=$(pwd)/gitconfig" Enter
Type "cd /tmp && rm -rf vhsdemo-repo && mkdir vhsdemo-repo && cd vhsdemo-repo && git init -b main" Enter
Sleep 300ms
Type "git config user.email 'demo@example.com'" Enter
Sleep 200ms
# Create some files and commits for a realistic history
Type "echo 'hello world' > README.md && git add README.md && git commit -m 'Initial commit'" Enter
Sleep 300ms
Type "echo 'second line' >> README.md && git add README.md && git commit -m 'Update readme'" Enter
Sleep 300ms
Type "echo 'function main() {}' > app.js && git add app.js && git commit -m 'Add app entry point'" Enter
Sleep 300ms
Type "clear" Enter
Sleep 300ms
Show

# === Show aliases — status ====================================================
Sleep 500ms
Type "# git st = status" Enter
Sleep 400ms
Type "git st" Enter
Sleep 800ms

# === Show aliases — branch name ===============================================
Type "# git cb = current branch name" Enter
Sleep 400ms
Type "git cb" Enter
Sleep 800ms

# === Show aliases — new branch ================================================
Type "# git nb = new branch" Enter
Sleep 400ms
Type "git nb feature/demo" Enter
Sleep 600ms
Type "git cb" Enter
Sleep 800ms

# === Show aliases — commit shorthand ==========================================
Type "echo 'new feature' > feature.txt" Enter
Sleep 300ms
Type "# git cam = commit -am (add + commit with message)" Enter
Sleep 400ms
Type "git cam 'Add new feature'" Enter
Sleep 800ms

# === Show aliases — uncommit ==================================================
Type "# git uncommit = soft reset last commit" Enter
Sleep 400ms
Type "git uncommit" Enter
Sleep 500ms
Type "git st" Enter
Sleep 800ms

# === Re-commit for diff demo =================================================
Hide
Type "git cam 'Add new feature'" Enter
Sleep 300ms
Show

# === Delta side-by-side diff ==================================================
Type "# delta pager — side-by-side, line numbers, Catppuccin Mocha" Enter
Sleep 400ms
Type "sed -i 's/new feature/improved feature/' feature.txt" Enter
Sleep 300ms
Type "git diff" Enter
Sleep 1500ms
Type "q"
Sleep 500ms

# === Delta for git log ========================================================
Type "git log --oneline" Enter
Sleep 1200ms

# === Show aliases — checkout back =============================================
Type "# git co = checkout" Enter
Sleep 400ms
Type "git co main" Enter
Sleep 800ms

# === Prune fetch ==============================================================
Type "# git pp = pull --prune" Enter
Sleep 400ms
Type "# git f  = fetch" Enter
Sleep 400ms
Type "# git po = pull origin <branch>" Enter
Sleep 800ms

# === Alias cheat sheet ========================================================
Type "# Full alias list:" Enter
Sleep 300ms
Type "git config --get-regexp alias" Enter
Sleep 2000ms

# === Cleanup (hidden) ========================================================
Hide
Type "cd / && rm -rf /tmp/vhsdemo-repo /tmp/vhsdemo-rc" Enter
Type "exit" Enter
