# af-magic.zsh-theme
# Repo: https://github.com/andyfleming/oh-my-zsh
# Direct Link: https://github.com/andyfleming/oh-my-zsh/blob/master/themes/af-magic.zsh-theme

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# primary prompt
_PWD()
{
    fullpath=$(print -P '%~')
    smallpath=$(print -P '%-2~/.../%2~')

    if (( ${#smallpath} < ${#fullpath} )); then
        echo "$smallpath"
    else
        echo "$fullpath"
    fi
}


_PWD2 ()
{
    local PRE= NAME="$(print -P '%~')" LENGTH="40";
    [[ "$NAME" != "${NAME#$HOME/}" || -z "${NAME#$HOME}" ]] &&
        PRE+='~' NAME="${NAME#$HOME}" LENGTH=$[LENGTH-1];
    ((${#NAME}>$LENGTH)) && NAME="/...${NAME:$[${#NAME}-LENGTH+4]}";
    echo "$PRE$NAME"
}

PROMPT='
$FG[032]$(_PWD)\
$(git_prompt_info) \
$FG[105]%(!.#.>)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'

# ranger info
if [ -n "$RANGER_LEVEL" ]
then
    RANGERPROMPT="$FG[250](ranger)%{$reset_color%} "
else
    RANGERPROMPT=''
fi

# virtualenv info
if [ -n "$VIRTUAL_ENV" ]
then
    VIRTUALPROMPT="$FG[250]($(basename "$(dirname "$VIRTUAL_ENV")"))%{$reset_color%} "
else
    VIRTUALPROMPT=''
fi

# right prompt
local TIME="$FG[245]%D{%I:%M:%S}%{$reset_color%}"
RPROMPT='$RANGERPROMPT$VIRTUALPROMPT$TIME'
# RPROMPT='$FG[237]%n@%m%{$reset_color%}%'

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX=" "
ZSH_THEME_GIT_PROMPT_CLEAN="$FG[075]"
ZSH_THEME_GIT_PROMPT_DIRTY="$FG[214]"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
