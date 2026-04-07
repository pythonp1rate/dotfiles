# Sane PATH order (fixes /sbin shadowing user apps)
set -gx PATH \
    ~/.local/bin \
    /usr/local/bin \
    /usr/bin \
    /bin

# Bat theme
set -gx BAT_THEME "Catppuccin-Macchiato"



fish_default_key_bindings
bind -e p
bind -M insert -e p
bind -M default -e p

source ~/.config/fish/user_variables.fish
source ~/.config/fish/abbreviations.fish
atuin init fish | source

function fish_prompt
    # Username in mauve (matches mads@archlinux)
    set_color "#EBC0EC"
    echo -n "mads "

    # Arrow
    set_color magenta
    echo -n "➜ "

    # Path / ~
    set_color "#EBC0EC"
    echo -n (prompt_pwd)
    echo -n " "
end

# ─────────────────────────────────────────────
# Auto-load Fastfetch config based on terminal
# ─────────────────────────────────────────────
function fish_greeting
    if set -q KITTY_WINDOW_ID
        fastfetch --config ~/.config/fastfetch/config_kitty.jsonc
    else if test "$TERM_PROGRAM" = "Ghostty"
        fastfetch --config ~/.config/fastfetch/config_ghostty.jsonc
    else if test -n "$VSCODE_INJECTION" -o "$TERM_PROGRAM" = "vscode" -o "$TERM_PROGRAM" = "cursor" -o -n "$VSCODE_CLI" -o "$CHROME_DESKTOP" = "cursor.desktop" -o -n "$VSCODE_IPC_HOOK" -o -n "$VSCODE_CODE_CACHE_PATH"
        echo "⠀⠀⠀⠀⠀⢸⠓⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        echo "⠀⠀⠀⠀⠀⢸⠀⠀⠑⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        echo "⠀⠀⠀⠀⠀⢸⡆⠀⠀⠀⠙⢤⡷⣤⣦⣀⠤⠖⠚⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        echo "⣠⡿⠢⢄⡀⠀⡇⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠸⠷⣶⠂⠀⠀⠀⣀⣀⠀⠀⠀"
        echo "⢸⣃⠀⠀⠉⠳⣷⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠉⢉⡭⠋"
        echo "⠀⠘⣆⠀⠀⠀⠁⠀⢀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⠀⠀"
        echo "⠀⠀⠘⣦⠆⠀⠀⢀⡎⢹⡀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⡀⣠⠔⠋⠀⠀⠀⠀"
        echo "⠀⠀⠀⡏⠀⠀⣆⠘⣄⠸⢧⠀⠀⠀⠀⢀⣠⠖⢻⠀⠀⠀⣿⢥⣄⣀⣀⣀⠀⠀"
        echo "⠀⠀⢸⠁⠀⠀⡏⢣⣌⠙⠚⠀⠀⠠⣖⡛⠀⣠⠏⠀⠀⠀⠇⠀⠀⠀⠀⢙⣣⠄"
        echo "⠀⠀⢸⡀⠀⠀⠳⡞⠈⢻⠶⠤⣄⣀⣈⣉⣉⣡⡔⠀⠀⢀⠀⠀⣀⡤⠖⠚⠀⠀"
        echo "⠀⠀⡼⣇⠀⠀⠀⠙⠦⣞⡀⠀⢀⡏⠀⢸⣣⠞⠀⠀⠀⡼⠚⠋⠁⠀⠀⠀⠀⠀"
        echo "⠀⢰⡇⠙⠀⠀⠀⠀⠀⠀⠉⠙⠚⠒⠚⠉⠀⠀⠀⠀⡼⠁⠀⠀⠀⠀⠀⠀⠀⠀"
        echo "⠀⠀⢧⡀⠀⢠⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        echo "⠀⠀⠀⠙⣶⣶⣿⠢⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        echo "⠀⠀⠀⠀⠀⠉⠀⠀⠀⠙⢿⣳⠞⠳⡄⠀⠀⠀⢀⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠹⣄⣀⡤⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
    end
end

# ==============================
# GitHub Copilot CLI — Fish Wrapper
# ==============================

# Shell command assistant (??)
function wts
    github-copilot-cli what-the-shell $argv
end

alias "??"="wts"

# GitHub CLI command assistant (gh?)
function gh\?
    echo -n "Copilot> "
    read -l query
    if test -n "$query"
        github-copilot-cli gh-assist $query
    end
end

# Git command assistant (git?)
function git\?
    echo -n "Git Copilot> "
    read -l query
    if test -n "$query"
        github-copilot-cli git-assist $query
    end
end


# EC2 AWS 
function pia25
    cd ~/.ssh
    ssh -i PIA_25-AWS.pem ubuntu@16.170.34.34
    cd -
end

function stop25
    ssh -i ~/.ssh/PIA_25-AWS.pem ubuntu@16.170.34.34 "sudo shutdown -h now"
end

# linux_basic EC2
function basic_linux
    ssh -i ~/.ssh/linux_basic.pem ubuntu@13.51.90.131
end

function stopbl
    ssh -i ~/.ssh/linux_basic.pem ubuntu@13.51.90.131 'sudo shutdown -h now'
end







# ─── AWS EC2 SSH aliases ───

alias pia25 'ssh -i ~/.ssh/PIA_25-AWS.pem ubuntu@16.170.34.34'
alias stop25 'ssh -i ~/.ssh/PIA_25-AWS.pem ubuntu@16.170.34.34 "sudo shutdown -h now"'

alias linux_basic 'ssh -i ~/.ssh/linux_basic.pem ubuntu@13.51.90.131'
alias stoplb 'ssh -i ~/.ssh/linux_basic.pem ubuntu@13.51.90.131 "sudo shutdown -h now"'

alias basic_linux 'ssh -i ~/.ssh/basic_linux.pem ubuntu@16.16.161.145'
alias stopbl 'ssh -i ~/.ssh/basic_linux.pem ubuntu@16.16.161.145 "sudo shutdown -h now"'
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx LC_MESSAGES en_US.UTF-8
set -gx LANGUAGE en_US.UTF-8
gnome-keyring-daemon --start --components=secrets | source
