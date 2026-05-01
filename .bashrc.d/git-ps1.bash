export PROMPT_COMMAND='__set_ps1'

__set_ps1(){

	if git status > /dev/null 2>&1; then
		CURR_GIT_BRANCH="$(git symbolic-ref --short HEAD)"
		PROJECT_DIR="$(git rev-parse --show-toplevel)"
		PROJECT_NAME=$(basename -s .git $(git config --get remote.origin.url) 2> /dev/null || basename "$PROJECT_DIR")


		BRANCH_INSERT="\[${MAGENTA}\](${CURR_GIT_BRANCH})\[${RESET}\]"

		PROJECT_PATH="$(realpath . --relative-to="$PROJECT_DIR" | sed "s/^\.\{0,1\}/\//")"

		_path="\[${BOLD}${GREEN}\]@${PROJECT_NAME}\[${CYAN}\]:\[${GREEN}\]${PROJECT_PATH}\[${RESET}\] ${BRANCH_INSERT}"
	else
		PROJECT_DIR=""
		_dir=$(pwd | sed "s|^/home/zingale.joshua|~|")
		_path="\[${BOLD}${GREEN}\]${_dir}\[${RESET}\]"
	fi

	_visible_path=$(echo -e "$_path" | sed 's/\\\[[^\\]*\\\]//g')
	
	read TERM_ROWS TERM_COLS < <(stty size)

	_line_threashold=$((TERM_COLS/3))

	if [[ ${#_visible_path} -lt $_line_threashold ]]
	then _prompt=" " 
	else _prompt="\n"
	fi
		
	_prompt="${_prompt}\[${BOLD}${CYAN}\]\$\[${RESET}\] "

	export PS1="${_path}${_prompt}"

	
	if [[ $PROJECT_DIR != $LAST_PROJECT_DIR ]]; then

		[[ -n $LAST_PROJECT_DIR ]] && PATH=$(echo $PATH |
			(sed "s@$(__get_project_bin_path "$LAST_PROJECT_DIR"):*@@" || cat))
		[[ -n $PROJECT_DIR ]] && __add_to_path_if_not_in_path "$(__get_project_bin_path "$PROJECT_DIR")"
	fi

	LAST_PROJECT_DIR=$PROJECT_DIR	
}

__get_project_bin_path() {
	project_bin_dir="$1"

	[[ -d "$project_bin_dir/build" ]] && project_bin_dir="$project_bin_dir/build"

	if [[ -d "$project_bin_dir/bin" ]]; then
		echo "$project_bin_dir/bin"
	fi
}
