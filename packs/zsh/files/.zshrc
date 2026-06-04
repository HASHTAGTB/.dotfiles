# ========================================
# POWERLEVEL10K INSTANT PROMPT
# ========================================

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ========================================
# ADD ~/scripts TO PATH
# ========================================

if [[ -d "$HOME/scripts" ]]; then
    export PATH="$PATH:$HOME/scripts"
fi

# ========================================
# OPTIONS
# ========================================

# setopt CORRECT
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY HIST_REDUCE_BLANKS

HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
HISTORY_IGNORE="(&|[bf]g|c|clear|history|exit|q|pwd|* --help)"

# ========================================
# SOURCE ALIASES AND OTHER STUFF
# ========================================

if [[ -d "$HOME/.config/shell" ]]; then
    for file in "$HOME/.config/shell/"*{sh,zsh}; do
        [[ -r "$file" ]] && source "$file"
    done
fi

# ========================================
# ZINIT INTALL + LOAD
# ========================================

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
unalias zi

# ========================================
# SYNCHRONOUS PLUGINS
# ========================================

# Theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

# OMZ snippets (synchronous)
zinit snippet OMZP::git
zinit snippet OMZP::extract
zinit snippet OMZP::colored-man-pages
# zinit ice load'![[ $PLUGINS = 'zoxide' ]]' unload'![[ $PLUGINS != 'zoxide' ]]'
zinit snippet OMZP::zoxide

# zsh vi mode
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
zvm_after_init_commands+=(eval "$(fzf --zsh)")

# ========================================
# ASYNCHRONOUS PLUGINS - TURBO MODE
# ========================================

# fast-syntax-highlighting before zsh-completions and zsh-autosuggestions
zinit ice wait lucid atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay'
zinit light zdharma-continuum/fast-syntax-highlighting

# case insensitive completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# zsh-completions — blockf prevents it from overriding fpath entries
zinit ice wait lucid blockf 
zinit light zsh-users/zsh-completions

zinit ice wait lucid atload'
  bindkey "^[[A" history-substring-search-up
  bindkey "^[[B" history-substring-search-down
  bindkey "^[OA" history-substring-search-up
  bindkey "^[OB" history-substring-search-down
' 
zinit load 'zsh-users/zsh-history-substring-search'

# Turbo-mode plugins — deferred until after first prompt
zinit ice wait lucid atload'_zsh_autosuggest_start' 
zinit light zsh-users/zsh-autosuggestions

# Must be last but fast-syntax-highlighting better
# zinit ice wait lucid atinit'zicompinit; zicdreplay'
# zinit light zsh-users/zsh-syntax-highlighting

# ========================================
# POWERLEVEL10K CONFIG
# ========================================

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
