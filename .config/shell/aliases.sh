alias update="sudo pacman -Syu"
alias uninstall="sudo pacman -Rsn"
alias install="sudo pacman -S"
alias please="sudo"
alias cleanup="sudo pacman -Rsn $(pacman -Qtdq)"
alias c="clear"
alias v="nvim"
alias inv='nvim $(fzf -m --style full --preview="bat -p --color=always {}")'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
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

alias -g borgumnt="borgmatic umount --mount-point /mnt/borg"
alias -g borgmnt="borgmatic mount --mount-point /mnt/borg --options allow_other --repository"
alias -g borgbak="borgmatic --repository"
