# ZSHRC
#
autoload -Uz promptinit && promptinit

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH" # $(brew --prefix coreutils)
export PATH="$HOME/.anaconda3/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export LANG=en_US.UTF-8
export XMODIFIERS=@im=uim
export GTK_IM_MODULE=uim

export XDG_CONFIG_HOME=$HOME/.config

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
alias ssh='autossh -M 0'

# enhancd config
export ENHANCD_FILTER=ENHANCD_FILTER=fzy:fzf:peco
export ENHANCD_HOOK_AFTER_CD=ls

# color scheme
eval `${commands[dircolors]:-"gdircolors"} $ZPLUG_HOME/repos/seebi/dircolors-solarized/dircolors.256dark`

# zcompile
if [ ! -f ~/.zshrc.zwc ] || [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi

# profiler
if (which zprof > /dev/null 2>&1) ;then
    zprof
fi


