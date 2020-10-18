autoload -Uz promptinit && promptinit

export PATH=$HOME/anaconda3/bin:$PATH
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/local/bin
export GOPATH=/usr/local/go
export PATH=$PATH::$GOPATH/bin
export PATH="$HOME/.cargo/bin:$PATH"
export EDITOR=nvim
export PYTHON3_HOST_PROG=${HOME}/anaconda3/envs/neovim/bin/python

# direnv
eval "$(direnv hook zsh)"

export LANG=en_US.UTF-8
export XMODIFIERS=@im=uim
export GTK_IM_MODULE=uim

export XDG_CONFIG_HOME=$HOME/.config

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

####################
# ZPLUG CONFIGURE
####################

# install zplug if it does not exist.
if [[ ! -d ~/.zplug  ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

# syntax
zplug "chrissicool/zsh-256color"
zplug "Tarrasch/zsh-colors"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "ascii-soup/zsh-url-highlighter"
zplug "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# ZSH port of Fish shell's history search feature
zplug "zsh-users/zsh-history-substring-search", defer:2

# prompt
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
setopt prompt_subst # Make sure prompt is able to be generated properly.

# color theme
zplug "seebi/dircolors-solarized", ignore:"*", as:plugin
eval `${commands[dircolors]:-"gdircolors"} $ZPLUG_HOME/repos/seebi/dircolors-solarized/dircolors.256dark`

# enhancd
zplug "b4b4r07/enhancd", use:init.sh
ENHANCD_FILTER=ENHANCD_FILTER=fzy:fzf:peco
ENHANCD_HOOK_AFTER_CD=ls

# check updates
if [ ! ~/.zplug/last_zshrc_check_time -nt ~/.zshrc ]; then
    touch ~/.zplug/last_zshrc_check_time
    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
    fi
fi

zplug load

# vi keybind
bindkey -v

# command history
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups
setopt share_history

# command history search
autoload history-search-end
zle -N history-beginning-search-bachward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# env dependent settings
case ${OSTYPE} in
    darwin*)
        export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH" # $(brew --prefix coreutils)
        ;;
    linux*)
        alias nvim='eval $HOME/nvim.appimage'
        if [ "`lspci | grep -i nvidia`" ]; then
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
## zsh
alias sz='source ~/.zshrc'
alias vz='vi ~/.zshrc'
## jupyter 
alias jl='jupyter lab'

RPROMPT='%{$fg[green]%} %D{%Y/%m/%d} %* %{$reset_color%}'

alias station='eval $HOME/Station-1.65.0-x86_64.AppImage'

# zcompile
if [ ! -f ~/.zshrc.zwc ] || [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi

# profiler
if (which zprof > /dev/null 2>&1) ;then
    zprof
fi
