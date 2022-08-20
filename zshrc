autoload -Uz promptinit && promptinit

export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/local/bin:$PATH
export GOPATH=/usr/local/go
export PATH=$GOPATH/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export EDITOR=nvim
[[ ! -v ANACONDA_PATH ]] && export ANACONDA_PATH=$HOME/anaconda3
[[ ! -v PYTHON3_HOST_PROG ]] && export PYTHON3_HOST_PROG=$ANACONDA_PATH/envs/neovim/bin/python # for neovim in docker container

# deno
export DENO_INSTALL="/home/abemi/.deno"
if [ ! -d "${DENO_INSTALL}" ]; then
    # install deno
    curl -fsSL https://deno.land/install.sh | sh
fi
export PATH="$DENO_INSTALL/bin:$PATH"

# direnv
type direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"

export LANG=en_US.UTF-8
export XMODIFIERS=@im=uim
export GTK_IM_MODULE=uim

export XDG_CONFIG_HOME=$HOME/.config

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# [[ -f ~/.config/gnome-terminal/onehalfdark.sh ]] && source ~/.config/gnome-terminal/onehalfdark.sh

####################
# ZINIT CONFIGURE
####################
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

zinit light "chrissicool/zsh-256color"
zinit ice wait'1a' lucid; zinit light "zdharma-continuum/fast-syntax-highlighting"
zinit light "ascii-soup/zsh-url-highlighter"
zinit light "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# ZSH port of Fish shell's history search feature
zinit ice wait'1b' lucid atinit"
bindkey "$key[Up]" history-substring-search-up
bindkey "$key[Down]" history-substring-search-down
bindkey '^[k' history-substring-search-up
bindkey '^[j' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
"; zinit light "zsh-users/zsh-history-substring-search"

# prompt
zinit light "mafredri/zsh-async"
zinit light "sindresorhus/pure"
setopt prompt_subst # Make sure prompt is able to be generated properly.

# fzf
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf-bin

# enhancd -  A next-generation cd command with an interactive filter
zinit ice wait'2' lucid pick 'init.zsh'; zinit light "b4b4r07/enhancd"
ENHANCD_FILTER=fzf; export ENHANCD_FILTER
ENHANCD_HOOK_AFTER_CD=ls

# interactive jq
zinit ice wait'1' lucid; zinit light "reegnz/jq-zsh-plugin"

# vi keybind
bindkey -v

# Yank to the system clipboard
function vi-yank-xclip {
    zle vi-yank
    echo "$CUTBUFFER" | xsel --clipboard --input
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# command history
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups
setopt share_history

setopt auto_list
setopt auto_menu

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# env dependent settings
case ${OSTYPE} in
    darwin*)
        export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH" # $(brew --prefix coreutils)
        ;;
    linux*)
        if `type lspci >/dev/null 2>&1 && lspci | grep -i nvidia >/dev/null 2>&1`; then
            alias topgpu='watch -n1 "nvidia-smi | sed -e '\''1,7d'\'' -e '\''s/[-+]/ /g'\'' -e '\''/^ /d'\''"'
            alias psgpu='nvidia-smi | grep MiB | grep -v Default | awk "// {print \$3}" | xargs -I{} ps u {} | grep -v USER'
            # path for cuda
            export CUDA_PATH=/usr/local/cuda
            export PATH=$CUDA_PATH/bin${PATH:+:${PATH}}
            export CPATH=$CUDA_PATH/include${CPATH:+:${CPATH}}
            export LD_LIBRARY_PATH=$CUDA_PATH/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
        fi
        ;;
esac

# alias
alias diff="${commands[colordiff]:-diff} -u"
alias ls="ls -F --color"
alias history="history -E 1"
if type autossh > /dev/null 2>&1; then
    alias ssh='autossh -M 0'
fi
alias pbcopy=${commands[pbcopy]:-"xsel --clipboard --input"}
## git
alias gs='git status'
alias ga='git add'
alias gco='git checkout'
alias gcm='git commit -m'
alias gca='git commit --amend --no-edit'
alias gp='git push'
alias gpo='git push origin'
alias gd='git diff'
alias gt='git tree'
alias gm='git merge'
alias grs='git reset --staged'

# RPROMPT='%{$fg[green]%} %D{%Y/%m/%d} %* %{$reset_color%}'

alias station='eval $HOME/Station-1.65.0-x86_64.AppImage'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# zcompile
if [ ! -f ~/.zshrc.zwc ] || [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi

setopt extended_history

setopt extended_glob
setopt equals
setopt magic_equal_subst
setopt numeric_glob_sort


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('${ANACONDA_PATH}/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${ANACONDA_PATH}/etc/profile.d/conda.sh" ]; then
        . "${ANACONDA_PATH}/etc/profile.d/conda.sh"
    else
        export PATH="${ANACONDA_PATH}/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
