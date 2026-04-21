if [ -f "$HOME/.env" ]; then
	export $(grep -v '^\s*#' "$HOME/.env" | xargs)
fi
