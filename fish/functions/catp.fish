function catp --wraps='bat --paging=always' --description 'alias catp=bat --paging=always'
    if type -f bat &>/dev/null
        bat --theme='Catppuccin-Macchiato' --paging=always $argv
    else
        command cat --paging=always $argv
    end
end
