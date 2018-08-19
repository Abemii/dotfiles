alias quitjupyter="kill '(pgrep jupyter)'"
#deleted

set -x PATH LANG=ja_JP.UTF-8 $PATH
set -x PATH XMODIFIERS=@im=uim $PATH
set -x PATH GTK_IM_MODULE=uim $PATH

set -x PATH /Users/abemi/.pyenv/versions/anaconda3-5.0.0/bin $PATH
set -x PATH /usr/local/texlive/2017/bin/x86_64-darwin $PATH

alias vim='/usr/local/bin/nvim'

alias ssh='autossh -M 0'

alias nvvp='/Developer/NVIDIA/CUDA-9.2/bin/nvvp'

#deleted
alias sshfsh='sshfs home:/media/abemi/ボリューム/Users/nattsun/ ~/mph'

alias ds9='/Applications/SAOImageDS9.app/Contents/MacOS/ds9'

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

# fish vi settings
function fish_user_key_bindings
  for mode in insert default visual
    fish_default_key_bindings -M $mode
  end
  fish_vi_key_bindings --no-erase
end

# pure configure
set pure_color_red
set pure_username_color $pure_color_yellow
set pure_host_color $pure_color_green
set pure_root_color $pure_color_red

# for nvim
set FISH_HOME '/usr'

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'
