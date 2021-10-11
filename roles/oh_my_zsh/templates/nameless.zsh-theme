{% raw %}local base_color="%{$FG[046]%}";

function git_prompt_nameless() {
  $(git rev-parse --is-inside-work-tree > /dev/null 2>&1) || return

  local ref

  ref="$(command git name-rev --name-only --no-undefined --always HEAD 2>/dev/null) | $(git rev-parse --short HEAD 2>/dev/null)"
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#tags/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

if [[ $UID -eq 0 ]];
then
    local base_color="%{$FG[160]%}";
elif [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]];
then
    local base_color="%{$FG[226]%}";
fi

local user_host="${base_color}{%n@%m}%{$reset_color%}";
local place="%{$FG[033]%}{%~}%{$reset_color%}";
local cursor="${base_color}%#%{$reset_color%}";
local return_code="%(?..%{$FG[160]%}{↳ %?}%{$reset_color%})";
local time="%{$FG[033]%}{time %*}%{$reset_color%}";

local php_version=$(php -v 2>&1 | grep --color=never -oe '^PHP\s*[0-9.]\+' | awk '{print $2}');

if [ -z "${php_version}" ]; then
    local php_version_formatted="{php ---}";
else
    local php_version_formatted="{php v${php_version}}";
fi;

PROMPT='${user_host} ${place} $(git_prompt_nameless)
${cursor} ';
RPROMPT='${return_code} ${php_version_formatted} ${time}';

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[201]%}{± ";
ZSH_THEME_GIT_PROMPT_SUFFIX="}%{$FG[$code]%}";
ZSH_THEME_GIT_PROMPT_DIRTY="*";
ZSH_THEME_GIT_PROMPT_CLEAN="";
{% endraw %}
