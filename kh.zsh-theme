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

function show_path() {
  if [ -z $(get_tag) ]; then
    echo "%m@" $(get_pwd)
  else
    echo "%m@"
  fi
}

function show_time() {
  local git=$(git_prompt_info)
  if [ ${#git} != 0 ]; then
      (( git = ${#git} - 44 ))
  else
      git=0
  fi

  local space_count
    (( space_count = ${COLUMNS} - ${#$(show_path)} - ${#$(get_tag)} - ${git} - ${#$(get_time)} - 28))

  if [ $space_count -gt 0 ]; then
    local fill=""
    for i in {1..$space_count}; do
        fill="${fill} "
    done
    echo $fill$(get_time)
  fi
}

prompt_status() {
  local sym
  [[ $(jobs -l | wc -l) -gt 0 ]]  && sym+="⚙"|| sym+="●"
  echo $sym
}

local ret_status="%(?:%{$fg[cyan]%}:%{$fg_bold[red]%})"

PROMPT='$ret_status$(prompt_status) $fg_bold[cyan]$(show_path)$fg_bold[yellow]$(get_tag) $(git_prompt_info) $fg_bold[cyan]>$reset_color '
# $(show_time)

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} ✗$fg[blue])"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}% % % )" # don't remove the % symbol. it is the cheapest way to make it arrange, under different situations.
