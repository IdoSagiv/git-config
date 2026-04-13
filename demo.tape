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
Type "printf '# My Project\n\nA sample project.\n\n## Getting Started\n\nRun the app:\n\n  ./start.sh\n\n## License\n\nMIT\n' > README.md && git add README.md && git commit -m 'Initial commit'" Enter
Sleep 300ms
Type "echo 'function main() {}' > app.js && git add . && git commit -m 'Add app entry point'" Enter
Sleep 300ms
Type "clear" Enter
Sleep 300ms
Show

# === Aliases: status, branch name, new branch ================================
Sleep 500ms
Type "# git st = status" Enter
Sleep 400ms
Type "git st" Enter
Sleep 800ms

Type "# git cb = current branch name" Enter
Sleep 400ms
Type "git cb" Enter
Sleep 800ms

Type "# git nb = new branch" Enter
Sleep 400ms
Type "git nb feature/demo" Enter
Sleep 600ms
Type "git cb" Enter
Sleep 800ms

# === Aliases: commit and uncommit =============================================
Type "echo 'console.log(hello)' >> app.js" Enter
Sleep 300ms
Type "# git cam = commit -am (add + commit with message)" Enter
Sleep 400ms
Type "git cam 'Add hello log'" Enter
Sleep 800ms

Type "# git uncommit = soft reset last commit" Enter
Sleep 400ms
Type "git uncommit" Enter
Sleep 500ms
Type "git st" Enter
Sleep 800ms

# === Delta side-by-side diff ==================================================
# Hidden: recommit, edit README, clear screen
Hide
Type "git cam 'Add hello log'" Enter
Sleep 300ms
Type "sed -i 's/A sample project./A demo project showcasing git aliases./' README.md" Enter
Sleep 200ms
Type "sed -i 's/Run the app:/Install and run:/' README.md" Enter
Sleep 200ms
Type "sed -i 's|./start.sh|git clone repo \&\& ./start.sh|' README.md" Enter
Sleep 200ms
Type "clear" Enter
Sleep 300ms
Show

Sleep 300ms
Type "# delta pager — side-by-side, line numbers, Catppuccin Mocha" Enter
Sleep 400ms
Type "git diff" Enter
Sleep 3000ms

# === Git log ==================================================================
# Hidden: quit pager (if any) and clear for clean log output
Hide
Type "q"
Sleep 300ms
Enter
Sleep 300ms
Type "git checkout -- ." Enter
Sleep 300ms
Type "clear" Enter
Sleep 300ms
Show

Sleep 300ms
Type "git log --oneline" Enter
Sleep 1500ms

# === Checkout =================================================================
Type "# git co = checkout" Enter
Sleep 400ms
Type "git co main" Enter
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
