# ZSHRC
#
autoload -U promptinit; promptinit

if [ `uname` = 'Darwin' ]; then  # my local pc
    # this is originally for home dir of external file server, but here for common configs
    export EXT_HOME=$HOME

    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
    export PATH="$EXT_HOME/.anaconda3/bin:$PATH"
    export PATH=$PATH:/usr/local/texlive/2017/bin/x86_64-darwin

    # sshfs
#deleted
    alias sshfsh='sshfs home:/media/abemi/ボリューム/Users/nattsun/ ~/mph'

    # software launch from commad line
    alias ds9='/Applications/SAOImageDS9.app/Contents/MacOS/ds9'
    alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

#deleted

    # export EXT_HOME=/path/to/external/home/dir
    alias nvim='eval ${EXT_HOME}/nvim.appimage'

    export PATH=$EXT_HOME/.anaconda3/bin:$PATH
    export PATH=$EXT_HOME/ctags-5.8:$PATH
    export XAUTHORITY=$EXT_HOME/.Xauthority

    if [ "`lspci | grep -i nvidia`" ]; then
        alias topgpu='watch -n1 "nvidia-smi | sed -e '\''1,7d'\'' -e '\''s/[-+]/ /g'\'' -e '\''/^ /d'\''"'
        alias psgpu='nvidia-smi | grep MiB | grep -v Default | awk "// {print \$3}" | xargs -I{} ps u {} | grep -v USER'

        # path for cudnn
        export LD_LIBRARY_PATH=$HOME/.cudnn/active/cuda/lib64:$LD_LIBRARY_PATH
        export CPATH=$HOME/.cudnn/active/cuda/include:$CPATH
        export LIBRARY_PATH=$HOME/.cudnn/active/cuda/lib64:$LIBRARY_PATH

        # path for cuda-8.0
        export PATH=/usr/local/cuda-8.0/bin:$PATH
        export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64:$LD_LIBRARY_PATH

        # path for cuda-9.1
        export PATH=/usr/local/cuda/bin:$PATH
        export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

        # path for chainer
        export CFLAGS=-I$HOME/.cudnn/active/cuda/include
        export LDFLAGS=-L$HOME/.cudnn/active/cuda/lib64
        export LD_LIBRARY_PATH=$HOME/.cudnn/active/cuda/lib64:$LD_LIBRARY_PATH

        # path for nccl
        export NCCL_ROOT=$EXT_HOME/nccl
        export CPATH=$NCCL_ROOT/include:$CPATH
        export LD_LIBRARY_PATH=$NCCL_ROOT/lib/:$LD_LIBRARY_PATH
        export LIBRARY_PATH=$NCCL_ROOT/lib/:$LIBRARY_PATH

        # path for openmpi
        export LD_LIBRARY_PATH=$EXT_HOME/openmpi/lib:$LD_LIBRARY_PATH
        export PATH=$EXT_HOME/openmpi/bin:$PATH
    fi
    export XDG_CONFIG_HOME=$EXT_HOME/.config
fi


export LANG=ja_JP.UTF-8
export XMODIFIERS=@im=uim
export GTK_IM_MODULE=uim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

# ZSH port of Fish shell's history search feature
zplug "zsh-users/zsh-history-substring-search", defer:2

# prompt
zplug "mafredri/zsh-async", from:github
# zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "Abemii/pure", use:pure.zsh, from:github, as:theme
setopt prompt_subst # Make sure prompt is able to be generated properly.

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
alias history="history -E 1"
if [ `uname` = "Darwin" ]; then
    alias ssh='autossh -M 0'
fi

# enhancd config
export ENHANCD_FILTER=ENHANCD_FILTER=fzy:fzf:peco
export ENHANCD_HOOK_AFTER_CD=ls

# color scheme
eval `${commands[dircolors]:-"gdircolors"} $ZPLUG_HOME/repos/seebi/dircolors-solarized/dircolors.256dark`

# zcompile
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi

# profiler
if (which zprof > /dev/null 2>&1) ;then
    zprof
fi

if [[ -n $"EXT_HOME" ]]; then
    cd $EXT_HOME
fi
