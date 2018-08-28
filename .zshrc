# # profiling
# zmodload zsh/zprof && zprof
#
autoload -U promptinit; promptinit

hn=$(hostname)
if [ `echo $hn | grep 'Mac'` ]; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
    export PATH=$PATH:/Users/abemi/.pyenv/versions/anaconda3-5.0.0/bin
    export PATH=$PATH:/usr/local/texlive/2017/bin/x86_64-darwin
    
    # python
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    # sshfs
#deleted
    alias sshfsh='sshfs home:/media/abemi/ボリューム/Users/nattsun/ ~/mph'

    # software launch from commad line
    alias ds9='/Applications/SAOImageDS9.app/Contents/MacOS/ds9'
    alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

elif [ `echo $hn | grep 'hpc.vpl.nii.ac.jp'` ]; then

    # my home dir of external storage
#deleted
    
    # neovim
#deleted

    # path for python (anaconda)
    export PATH=$EXT_HOME/anaconda3/bin:$PATH
    
    export XAUTHORITY=$EXT_HOME/.Xauthority
    
#deleted

    if [ `echo $hn | grep 'pec4130'` ]; then
    	alias topgpu='watch -n1 nvidia-smi'
    	alias psgpu='nvidia-smi | grep MiB | grep -v Default | awk "// {print \$3}" | xargs -I{} ps u {} | grep -v USER'
    
        # path for cudnn
        export LD_LIBRARY_PATH=$HOME/.cudnn/active/cuda/lib64:$LD_LIBRARY_PATH
        export CPATH=$HOME/.cudnn/active/cuda/include:$CPATH
        export LIBRARY_PATH=$HOME/.cudnn/active/cuda/lib64:$LIBRARY_PATH
        
        # path for chainer
        export PATH=/usr/local/cuda-8.0/bin:$PATH
        export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64:$LD_LIBRARY_PATH
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
        
#deleted
        
        # path for cuda-9.2
        export PATH=$EXT_HOME/cuda-9.2/bin:$PATH
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$EXT_HOME/cuda-9.2/lib64/
    fi
    
    # export PATH="$EXT_HOME/.linuxbrew/bin:$PATH"
    # export LD_LIBRARY_PATH="$EXT_HOME/.linuxbrew/lib:$LD_LIBRARY_PATH"
    
    export XDG_CONFIG_HOME=$EXT_HOME/.config
elif [ `echo $hn | grep 'ubuntu'` ]; then

    alias tmux="TERM=screen-256color-bce tmux"
    
    # fish
    # exec fish
    
    # added by Anaconda3 installer
    export PATH="/home/member/anaconda3/bin:$PATH"
    . /home/member/anaconda3/etc/profile.d/conda.sh

    alias topgpu='watch -n1 nvidia-smi'
    alias psgpu='nvidia-smi | grep MiB | grep -v Default | awk "// {print \$3}" | xargs -I{} ps u {} | grep -v USER'
fi


export LANG=ja_JP.UTF-8
export XMODIFIERS=@im=uim
export GTK_IM_MODULE=uim


# enhancd config
export ENHANCD_FILTER=ENHANCD_FILTER=fzy:fzf:peco
export ENHANCD_HOOK_AFTER_CD=ls

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ ! -d ~/.zplug  ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    if [ $? = 128 ] && [ `echo $hn | grep 'hpc.vpl.nii.ac.jp'` ]; then
        scp -r abemi@pec4130a.hpc.vpl.nii.ac.jp:/home/abemi/.zplug ~/.zplug
    fi
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
if [ `echo $hn | grep 'Mac'` ]; then
    alias vim='/usr/local/bin/nvim'
    alias ssh='autossh -M 0'
fi

alias nvvp='/Developer/NVIDIA/CUDA-9.2/bin/nvvp'
alias quitjupyter="kill '(pgrep jupyter)'"

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

if [[ -n $"EXT_HOME" ]]; then
    cd $EXT_HOME
fi
