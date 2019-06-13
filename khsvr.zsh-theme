KH_VCS_PROMPT_PREFIX1=" %{$fg_bold[blue]%}"
KH_VCS_PROMPT_PREFIX2="%{$fg_bold[blue]%}(%{$fg[cyan]%}"
KH_VCS_PROMPT_SUFFIX="%{$fg_bold[blue]%})%{$reset_color%}"
KH_VCS_PROMPT_DIRTY=" %{$fg[red]%}✗"
KH_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${KH_VCS_PROMPT_PREFIX1}git:${KH_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$KH_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$KH_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$KH_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(KH_hg_prompt_info)'
KH_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${KH_VCS_PROMPT_PREFIX1}hg${KH_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$KH_VCS_PROMPT_DIRTY"
		else
			echo -n "$KH_VCS_PROMPT_CLEAN"
		fi
		echo -n "$KH_VCS_PROMPT_SUFFIX"
	fi
}

# consul info
# local consul_member_info='$(KH_consul_member_info)'
# KH_consul_member_info() {
#   local sym
#   [[ -n $(where consul | grep consul) ]] && (sym+=$(consul members | grep server | wc -l) && sym+=$(ifconfig eth0 | grep inet | awk '{print $2}') && sym += " ") || ""
#   echo $sym
# }

# IP info
local ip_info='$(KH_ip_info)'
KH_ip_info() {
  local sym
  [[ -n $(where ipconfig | grep ipconfig) ]] && sym+=$(ipconfig getifaddr en0) || sym+=$(ifconfig eth0 | grep inet | awk '{print $2}')
  echo $sym
}

# JOBS info
local jobs_info='$(KH_jobs_info)'
KH_jobs_info() {
  local sym
  [[ $(jobs -l | wc -l) -gt 0 ]]  && sym+="⚙" || sym+="●"
  echo $sym
}

# TAG info
local tag_info='$(KH_tag_info)'
KH_tag_info() {
  local len
  (( len = ${#PROJPATH} ))

  local tag
  if [ ${PWD:0:$len} == ${PROJPATH} ]; then
    tag=${PWD:$len}
    echo "%{$fg_bold[yellow]%}ρ∷$tag%{$reset_color%}"
	else
		echo "%~"
  fi
}

local exit_code="%(?,,C:%{$fg[red]%}%?%{$reset_color%})"

PROMPT="
%{$terminfo[bold]$fg[blue]%}${jobs_info}%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$FG[128]%}%n) \
%{$fg[green]%}@${ip_info} \
${tag_info}\
${hg_info}\
${git_info}\
\
%{$FG[239]%}[%*] $exit_code
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
