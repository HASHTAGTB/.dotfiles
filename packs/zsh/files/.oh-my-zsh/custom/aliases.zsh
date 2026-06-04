# Put files in this folder to add your own custom functionality.
# See: https://github.com/ohmyzsh/ohmyzsh/wiki/Customization
#
# Files in the custom/ directory will be:
# - loaded automatically by the init script, in alphabetical order
# - loaded last, after all built-ins in the lib/ directory, to override them
# - ignored by git by default
#
# Example: add custom/shortcuts.zsh for shortcuts to your local projects
#
# brainstormr=~/dev/development/planetargon/brainstormr
# cd $brainstormr

alias update="sudo pacman -Syu"
alias uninstall="sudo pacman -Rsn"
alias install="sudo pacman -S"
alias please="sudo"
alias cleanup="sudo pacman -Rsn $(pacman -Qtdq)"
alias c="clear"
alias inv='nvim $(fzf -m --preview="bat -p --color=always {}")'
gcom() {
	git add .
	git commit -m "$1"
}

lazyg() {
	git add .
	git commit -m "$1"
	git push
}

y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
alias wlogout="wlogout --protocol layer-shell --buttons-per-row 6 --column-spacing 2 --row-spacing 0"
