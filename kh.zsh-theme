function get_pwd(){
  echo "${PWD/$HOME/~}"
}

function get_time() {
  echo "%D %T"
}

function get_tag() {
  local len
  (( len = ${#PROJPATH} ))

  local tag
  if [ ${PWD:0:$len} == ${PROJPATH} ]; then
    tag=${PWD:$len}
    echo ρ∷$tag
  fi
}

function get_path() {
  if [ -z $(get_tag) ]; then
    echo "%m@" $(get_pwd)
  else
    echo "%m@"
  fi
}

function put_spacing() {
  local git=$(git_prompt_info)
  if [ ${#git} != 0 ]; then
      (( git = ${#git} - 44 ))
  else
      git=0
  fi

  local termwidth
    (( termwidth = ${COLUMNS} - ${#$(get_path)} - ${#$(get_tag)} - ${git} - ${#$(get_time)} - 26))

  local spacing=""
  for i in {1..$termwidth}; do
      spacing="${spacing} "
  done
  echo $spacing
}

local ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})"

PROMPT='● $fg_bold[cyan]$(get_path)$fg_bold[yellow]$(get_tag) $(git_prompt_info)$reset_color$(put_spacing)$fg_bold[white]$(get_time)$reset_color
'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} ✗$fg[blue])"
# don't remove the % symbol. it is the cheapest way to make it arrange, under different situations.
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}% % % )" 
