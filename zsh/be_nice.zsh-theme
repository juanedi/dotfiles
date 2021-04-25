# use spectrum_ls to consult available colors
local dir_color="$FG[073]"
local info_color="$FG[110]"

direnv_prompt_info () {
    if [ $DIRENV_DIFF ]
    then
        echo "[envrc]"
    fi
}

dir_section () {
    echo "%{$dir_color%}%c%{$reset_color%}"
}
info_section () {
    echo "%{$info_color%}$(direnv_prompt_info)$(git_prompt_info)%{$reset_color%}"
}
local ret_status="%(?:%{$info_color%}> :%{$FG[009]%}> )%{$reset_color%}"

PROMPT='$(dir_section)$(info_section) ${ret_status}'
ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
