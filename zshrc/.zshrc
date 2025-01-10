# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by newuser for 5.9
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# General aliases
alias zsh-edit="nvim ~/.zshrc"
alias source-zsh="source ~/.zshrc"
alias nvc="nvim ~/.config/nvim"
# alias spm="sudo pacman"
# alias pm="pacman"
alias docker="sudo docker"
alias copy="xsel --clipboard --input"
alias paste="xsel --clipboard --output"

# Pythons aliases
alias p3="python3"
alias venv="python3 -m venv env"
alias svenv="source env/bin/activate"

# History setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey "^[[A" history-search-backward
bindkey "^[[b" history-search-forward


# Setup zsh plugins
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source <(fzf --zsh)
eval "$(zoxide init zsh)"
. "$HOME/.asdf/asdf.sh"

# ---- FZF -----
# Set up fzf key bindings and fuzzy completion
# eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"
export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview "eza --tree --color=always {} | head -200" "$@" ;;
    export|unset) fzf --preview "eval "echo \${}""         "$@" ;;
    ssh)          fzf --preview "dig {}"                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----- Bat (better cat) -----
export BAT_THEME=OneHalfDark
alias bat="batcat"

# ---- Eza (better ls) -----
alias ls="eza --color=always --icons=always --long --no-permissions --no-user --no-filesize"
alias ll="eza --color=always --icons=always --long  --no-filesize --no-permissions --no-user --no-time"
alias llm="eza --all --header --long --sort=modified $eza_params"
alias la="eza -lbhHigUmuSa"
alias lx="eza -lbhHigUmuSa@"
alias lt="eza --tree $eza_params"
alias ltree="eza --tree $eza_params"

# TMUX aliases
alias tat="tmux attach -t"
alias tns="tmux new -s"
alias trw="tmux rename-window"
alias trs="tmux rename-session"
alias tls="tmux ls"
alias tks="tmux kill-session -t"

# ---- TheFuck -----
# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# ------ Exercism --------
# [[ ":$PATH:" == *":$HOME/bin:"* || ":$PATH:" == *":~/bin:"* ]] && echo "~/bin is in PATH" || echo "~/bin is not in PATH"

alias cd="z"
