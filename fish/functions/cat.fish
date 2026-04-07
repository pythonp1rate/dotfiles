function cat --wraps=bat --description 'alias cat=bat'
    if type -f bat &>/dev/null; and [ -t 1 ]
        bat --theme='Catppuccin-Macchiato' $argv
    else
        command cat $argv
    end
end
