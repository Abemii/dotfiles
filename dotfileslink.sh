#~/bin/sh
hn=$(hostname)
if [ `echo $hn | grep 'Mac'` ]; then
    ln -sf ~/dotfiles/nvim/config/ ~/.config/nvim
    ln -sf ~/dotfiles/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish
elif [ `echo $hn | grep 'hpc.vpl.nii.ac.jp'` ]; then
    ln -sf $EXT_HOME/dotfiles/nvim/config/ $EXT_HOME/.config/nvim 
    ln -sf $EXT_HOME/dotfiles/fish_prompt.fish $EXT_HOME/.config/fish/functions/fish_prompt.fish
fi
