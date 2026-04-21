export PROMPT_COMMAND='__set_ps1'

__set_ps1(){
	CURR_GIT_BRANCH="$(git branch --show-curr 2> /dev/null)"

	[[ -n $CURR_GIT_BRANCH ]] && BRANCH_INSERT="(${CURR_GIT_BRANCH}) " || BRANCH_INSERT=""

	export PS1="\[${GREEN}\]\w \[${RED}\]${BRANCH_INSERT}\[${CYAN}\]\$\[${RESET}\] "
}
