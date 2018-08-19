# # profiling
# zmodload zsh/zprof && zprof

export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

export LANG=ja_JP.UTF-8
export XMODIFIERS=@im=uim
export GTK_IM_MODULE=uim

export PATH=$PATH:/Users/abemi/.pyenv/versions/anaconda3-5.0.0/bin
export PATH=$PATH:/usr/local/texlive/2017/bin/x86_64-darwin

# python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# enhancd config
export ENHANCD_FILTER=ENHANCD_FILTER=fzy:fzf:peco
export ENHANCD_HOOK_AFTER_CD=ls

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ ! -d ~/.zplug  ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

# syntax
zplug "chrissicool/zsh-256color"
zplug "Tarrasch/zsh-colors"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "ascii-soup/zsh-url-highlighter"

# ZSH port of Fish shell's history search feature
zplug "zsh-users/zsh-history-substring-search", defer:2

# prompt
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

# color theme
zplug "seebi/dircolors-solarized", ignore:"*", as:plugin

# enhancd
zplug "b4b4r07/enhancd", use:init.sh

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

# alias
alias diff="colordiff"
alias ls="ls -F --color"
alias vim='/usr/local/bin/nvim'
alias ssh='autossh -M 0'

alias nvvp='/Developer/NVIDIA/CUDA-9.2/bin/nvvp'
alias quitjupyter="kill '(pgrep jupyter)'"

# sshfs
#deleted
alias sshfsh='sshfs home:/media/abemi/ボリューム/Users/nattsun/ ~/mph'

# software launch from commad line
alias ds9='/Applications/SAOImageDS9.app/Contents/MacOS/ds9'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

# color scheme
eval `dircolors $ZPLUG_HOME/repos/seebi/dircolors-solarized/dircolors.256dark`

# zcompile
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi

# profiler
if (which zprof > /dev/null 2>&1) ;then
    zprof
fi
