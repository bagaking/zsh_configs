# The project commond
# PROJPATH will be used in kh.zsh-theme
# config :
export PROJPATH=~/proj

# The jump method
# @usage : proj [scope] [projname]
# config :
proj() {
	if [[ $1 != "" ]]; then
		printf "cd $PROJPATH/%s/%s && pwd && ll \n" $1 $2 > ~/temp_cmd
		source ~/temp_cmd
	else
		echo "cd $PROJPATH && ll" > ~/temp_cmd
		source ~/temp_cmd
	fi
}

# Set current theme to kh.zsh-theme
# config :
ZSH_THEME="kh"

# Using zsh-syntax-highlighting
# @see https://github.com/zsh-users/zsh-syntax-highlighting 
# config :
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh