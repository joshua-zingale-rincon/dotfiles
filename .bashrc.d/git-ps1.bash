export PROMPT_COMMAND='__set_ps1'

__set_ps1(){

	if git status > /dev/null 2>&1; then
		CURR_GIT_BRANCH="$(git branch --show-curr)"
		PROJECT_DIR="$(git rev-parse --show-toplevel)"
		PROJECT_NAME=$(basename -s .git $(git config --get remote.origin.url) 2> /dev/null || basename "$PROJECT_DIR")

		BRANCH_INSERT="\[${MAGENTA}\](${CURR_GIT_BRANCH}) "

		PROJECT_PATH="$(realpath . --relative-to="$PROJECT_DIR" | sed "s/^\.\{0,1\}/\//") "


		export PS1="\[${BOLD}${GREEN}\]@${PROJECT_NAME}\[${CYAN}\]:\[${GREEN}\]${PROJECT_PATH}\[${RESET}\]${BRANCH_INSERT}\[${BOLD}${CYAN}\]\$\[${RESET}\] "
	else
		export PS1="\[${BOLD}${GREEN}\]\w \[${CYAN}\]\$\[${RESET}\] "
	fi


	
}
