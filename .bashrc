export PATH="$HOME/.local/bin:$PATH"

if [[ -z $NO_COLOR ]]; then
	GREEN="\e[32;1m"
	CYAN="\e[36;1m"
	RED="\e[31m"
	RESET="\e[0m"
else 
	GREEN=""
	CYAN=""
	RED=""
	RESET=""
fi

if [[ -d "$HOME/.bashrc.d" ]]; then
	for config in "$HOME/.bashrc.d/"*.bash; do
		[[ -r "$config" ]] && . "$config"
	done
fi
