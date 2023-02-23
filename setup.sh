#!/usr/bin/env bash

set -Ce

echoI () {
    echo -e "\e[32m$1\e[m"
}

echoE () {
    echo -e "\e[31m$1\e[m"
}

# ostype
IS_LINUX=false
IS_DEBIAN=false
IS_ARCH=false
IS_MAC=false
if [ "`uname`" == "Darwin" ]; then
    IS_MAC=true
    echoI "MacOS"
elif [ "`uname`" == "Linux" ]; then
    IS_LINUX=true
    echoI "LInux"
    if `type apt >/dev/null 2>&1`; then
        IS_DEBIAN=true
	echoI "Debian"
    elif `type pacman >/dev/null 2>&1`; then
        IS_ARCH=true
	echoI "Arch"
    fi
else
    echoE "FAIL"
    exit 1
fi

# check if you have sudo priviledge in linux
IS_SUDOER=false
if $IS_LINUX; then
    # if `id $USER | grep "sudo" > /dev/null 2>&1`; then
    if `sudo -l -U $USER >/dev/null 2>&1`; then
        IS_SUDOER=true
        echoI "You are sudoer."
    else
        echoE "You are not sudoer."
        INSTALL_PATH="${HOME}/local"
        echo "INSTALL_PATH=${INSTALL_PATH}"
    fi
fi

# install software
echoI "Install software"

brew_install () {
    software_name=$1
    echoI "Install ${software_name} ..."
    if ! { brew list | grep ${software_name} > /dev/null 2>&1; } then
        brew install ${software_name}
        if [[ $? -eq 0 ]]; then
            echo "${software_name} is successfully installed."
        else
            echoE "failed to install ${software_name}."
        fi
    else
        echo "${software_name} is already installed."
    fi
}

brew_install_cask () {
    software_name=$1
    echoI "install ${software_name} ..."
    if ! { brew list --cask | grep ${software_name} > /dev/null 2>&1; } then
        brew install --cask ${software_name}
        if [[ $? -eq 0 ]]; then
            echo "${software_name} is successfully installed."
        else
            echoE "failed to install ${software_name}."
        fi
    else
        echo "${software_name} is already installed."
    fi
}

if $IS_MAC; then
    echo "Install homebrew"
    if ! { type brew > /dev/null 2>&1; }; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 
    fi

    brew_install coreutils
    brew_install wget
    brew_install iproute2mac
    brew_install_cask alacritty
    [[ ! -L ~/.config/alacritty ]] && ln -s $(pwd)/alacritty ~/.config/alacritty
    brew_install_cask firefox
    brew_install_cask google-japanese-ime
    brew_install_cask scroll-reverser
    brew_install_cask karabiner-elements
    brew_install_cask shiftit
    brew_install_cask dropbox

fi

# to save yanked to clipboard in neovim
if ! { type xclip > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y xclip
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S xclip
    fi
fi

# for pbcopy alias
if ! { type xsel > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y xsel
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S xsel
    fi
fi


if $IS_MAC; then
    echoI "Mac Global settings"
    ## no crash report
    defaults write com.apple.CrashReporter DialogType -string "none"

    ## no dashboard
    defaults write com.apple.dashboard mcx-disabled -bool true

    ## dock
    defaults write com.apple.dock autohide-delay -float 0

    ## screen capture
    defaults write com.apple.screencapture disable-shadow -bool true
    defaults write com.apple.screencapture type -string "png"
    if [ ! -d ~/Pictures/ScreenShots ]; then
        mkdir ~/Pictures/ScreenShots
    fi
    defaults write com.apple.screencapture location ~/Pictures/ScreenShots/
fi


function build_zsh_from_source () {
    INSTALL_DIR=$1

    # download ncurses
    mkdir -p tmp
    pushd tmp
        # install ncurses
        NCURSES_VERSION="6.2"
        wget https://ftp.gnu.org/pub/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz
        tar zxf ncurses-${NCURSES_VERSION}.tar.gz
        pushd ncurses-${NCURSES_VERSION}
            export CXXFLAGS=' -fPIC'
            export CFLAGS=' -fPIC'
            # mkdir build
            # pushd build
                ./configure --prefix=$INSTALL_DIR --enable-shared
                make
                make install
            # popd
        popd

        # install zsh
        ZSH_INSTALL_VERSION="5.7.1"
        wget -O zsh-${ZSH_INSTALL_VERSION}.tar.xz https://sourceforge.net/projects/zsh/files/zsh/${ZSH_INSTALL_VERSION}/zsh-${ZSH_INSTALL_VERSION}.tar.xz/download
        tar xf zsh-${ZSH_INSTALL_VERSION}.tar.xz
        pushd zsh-${ZSH_INSTALL_VERSION}
            # mkdir build
            # pushd build
                export PATH=$INSTALL_PATH/bin:$PATH
                export LD_LIBRARY_PATH=$INSTALL_PATH/lib:$LD_LIBRARY_PATH
                export CFLAGS=-I$INSTALL_PATH/include
                export CPPFLAGS=-I$INSTALL_PATH/include
                export LDFLAGS=-L$INSTALL_PATH/lib
                ./configure --prefix=$INSTALL_DIR --enable-shared
                make
                make install
            # popd
        popd
    popd
}


# install zsh and set as default shell
if ! { type zsh > /dev/null 2>&1; } then
    echoI "ZSH is not installed. Install zsh...."
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y zsh
        echo "change default shell to zsh...."
        sudo sh -c "echo $(which zsh) >> /etc/shells"
        chsh -s $(which zsh)
    elif $IS_ARCH && $IS_SUDOER; then
	    yes | yay -S -y zsh
        echo "change default shell to zsh...."
        sudo sh -c "echo $(which zsh) >> /etc/shells"
        chsh -s $(which zsh)
    elif $IS_LINUX && ! $IS_SUDOER; then 
        build_zsh_from_source $INSTALL_PATH
        echo "change default shell to zsh...."
        echo "export SHELL=${INSTALL_PATH}/bin/zsh" >> ~/.bash_profile
        echo "exec ${INSTALL_PATH}/bin/zsh -l"      >> ~/.bash_profile
        export PATH="${INSTALL_PATH}/bin:$PATH"
    elif $IS_MAC; then
        brew install zsh
        echo "change default shell to zsh...."
        sudo sh -c "echo $(which zsh) >> /etc/shells"
        chsh -s $(which zsh)
    fi
fi

if { echo $SHELL | grep zsh > /dev/null 2>&1; } then
    echoI "default shell is set to zsh"
else
    echoI "default shell is not set to zsh. set zsh as default"
    export SHELL=$(which zsh)
fi

# create symlink to zshrc
if [ ! -L ~/.zshrc ]; then
    echoI "create symbolic link to ~/.zshrc"
    ln -s $(pwd)/zshrc ~/.zshrc
fi


# install nvim
echoI "Install nvim"
if ! { type nvim > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y neovim
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S -y neovim
    elif $IS_LINUX && ! $IS_SUDOER; then
        wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -P $HOME
        chmod u+x $HOME/nvim.appimage
        echo "alias nvim='eval $HOME/nvim.appimage'" >> ~/.zshrc.local
    elif $IS_MAC; then
        brew install neovim
    fi
fi


# install python3 (anaconda)
echoI "Install miniconda3"
conda_dst="${HOME}/miniconda3"
if [ ! -d $conda_dst ]; then
    echo "install miniconda3 ...."
    if $IS_MAC; then
        conda_installer=Miniconda3-latest-MacOSX-x86_64.sh
    elif $IS_LINUX; then
        conda_installer=Miniconda3-latest-Linux-x86_64.sh
    fi
    if [ ! -f "tmp/${conda_installer}" ]; then
        wget https://repo.anaconda.com/miniconda/$conda_installer -P tmp
    fi
    bash tmp/$conda_installer -b -p $conda_dst

    echo "update conda ...."
    export PATH=$conda_dst/bin:$PATH
    conda update -y -n base -c defaults conda
else
    echo "anaconda3 already exists."
fi


# neovim settings
echoI "Setup nvim"

# /usr/bin/pip3 install pynvim jedi flake8 isort black jedi-language-server  # install to ~/.local/bin
# if ! { conda env list | grep neovim > /dev/null 2>&1; } then
#     echo "create conda env for neovim...."
#     conda create -y --name neovim python=3.8
#     source activate neovim
#     conda install -y -c conda-forge neovim jedi flake8 isort black jedi-language-server
#     conda deactivate
# else
#     echo "conda neovim env already exists."
# fi

if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi

if [ ! -L ~/.config/nvim ]; then
    echoI "create symbolic link to ~/.config/nvim" 
    ln -s $(pwd)/nvim/ ~/.config/
fi


function build_exuberant_ctags_from_source () {
    INSTALL_DIR=$1
    CTAGS_VERSION="5.8"

    mkdir -p tmp
    pushd tmp
        # install ctags
        wget http://prdownloads.sourceforge.net/ctags/ctags-${CTAGS_VERSION}.tar.gz
        tar zxf ctags-${CTAGS_VERSION}.tar.gz
        pushd ctags-${CTAGS_VERSION}
            # mkdir build
            # pushd build
                ./configure --prefix=$INSTALL_DIR
                make
                make install
            # popd
        popd
    popd
}

function build_universal_ctags_from_source () {
    INSTALL_DIR=$1
    CTAGS_VERSION="p5.9.20220206.0"

    git clone --depth 1 -b ${CTAGS_VERSION} https://github.com/universal-ctags/ctags.git /tmp/ctags
    pushd /tmp/ctags
        ./autogen.sh
        ./configure --prefix=${INSTALL_DIR}
        make
        make install # may require extra privileges depending on where to install
    popd
}

echoI "Install ctags"
if ! { type ctags > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        # sudo apt install -y exuberant-ctags
        sudo apt install -y universal-ctags
    elif $IS_ARCH && $IS_SUDOER; then
        # sudo apt install -y exuberant-ctags
        yes | yay -S universal-ctags
    elif $IS_LINUX && ! $IS_SUDOER; then
        # build_exuberant_ctags_from_source $INSTALL_PATH
        build_universal_ctags_from_source $INSTALL_PATH
    elif $IS_MAC; then
        brew install ctags
    fi
fi


function build_tmux_from_source () {
    INSTALL_DIR=$1
    OPENSSL_VERSION="1.1.1c"
    LIBEVENT_VERSION="2.1.12-stable"
    TMUX_VERSION="3.1b"

    mkdir -p tmp
    pushd tmp
        # install openssl
        wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
        tar zxf openssl-${OPENSSL_VERSION}.tar.gz
        pushd openssl-${OPENSSL_VERSION}
            # mkdir build
            # pushd build
                ./config --prefix=$INSTALL_DIR --openssldir=$INSTALL_DIR shared
                make
                make install
            # popd
        popd

        # install libevent
        wget https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}/libevent-${LIBEVENT_VERSION}.tar.gz --no-check-certificate
        tar zxf libevent-${LIBEVENT_VERSION}.tar.gz
        pushd libevent-${LIBEVENT_VERSION}
            # mkdir build
            # pushd build
                ./configure --prefix=$INSTALL_DIR
                make
                make install
            # popd
        popd

        # install tmux
        wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz --no-check-certificate
        tar zxf tmux-${TMUX_VERSION}.tar.gz
        pushd tmux-${TMUX_VERSION}
            # mkdir build
            # pushd build
               CFLAGS="-I/${INSTALL_DIR}/include/ncurses $CFLAGS"
               ./configure --prefix=$INSTALL_DIR
               make
               make install
            # popd
        popd
    popd
}


echoI "Install tmux"
if ! { type tmux > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y tmux
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S tmux
    elif $IS_LINUX && ! $IS_SUDOER; then
        build_tmux_from_source $INSTALL_PATH
    elif $IS_MAC; then
        brew install tmux
    fi
fi


echoI "Setup tmux"
if [ ! -L ~/.tmux.conf ]; then
    echo "create symbolic link to ~/.tmux.conf" 
    ln -s $(pwd)/tmux.conf ~/.tmux.conf
fi

function install_node () {
    INSTALL_DIR=$1
    NODE_VERSION=${2:-v16.14.0}
    wget https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz -P tmp
    pushd tmp
        tar Jxf node-${NODE_VERSION}-linux-x64.tar.xz
        rsync -avzP node-${NODE_VERSION}-linux-x64/* $INSTALL_DIR/
    popd
}


echoI "Install node"
if ! { type node > /dev/null 2>&1; } then
    if $IS_LINUX && ! $IS_SUDOER; then
        install_node $INSTALL_PATH
    elif $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y nodejs npm
        sudo npm install n -g -y
        sudo n stable
        sudo apt purge -y nodejs npm
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S nodejs npm
    fi
fi


echoI "Install deno"
if ! { type deno > /dev/null 2>&1; } then
    curl -fsSL https://deno.land/install.sh | sh
fi


echoI "Install htop"
if ! { type htop > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y htop
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S htop
    elif $IS_MAC; then
        brew install htop
    fi
fi


# # install nvtop
# echoI "Install nvtop"
# if ! { type nvtop > /dev/null 2>&1; } then
#     if $IS_DEBIAN && $IS_SUDOER; then
#         sudo apt install nvtop
#     fi
# fi


function build_ag_from_source () {
    INSTALL_DIR=$1
    AG_VERSION=${2:-2.2.0}

    mkdir -p tmp
    pushd tmp
        # install ctags
        wget https://geoff.greer.fm/ag/releases/the_silver_searcher-${AG_VERSION}.tar.gz
        tar zxf the_silver_searcher-${AG_VERSION}.tar.gz
        pushd the_silver_searcher-${AG_VERSION}
            # mkdir build
            # pushd build
                ./configure --prefix=$INSTALL_DIR
                make
                make install
            # popd
        popd
    popd
}


echoI "Install silversearcher-ag (ag)"
if ! { type ag > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y silversearcher-ag
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S the_silver_searcher 
    elif $IS_LINUX && ! $IS_SUDOER; then
        build_ag_from_source $INSTALL_PATH
    elif $IS_MAC; then
        brew install the_silver_searcher
    fi
fi


function install_rg () {
    INSTALL_DIR=$1
    RG_VERSION=${2:-13.0.0}

    wget https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz -P /tmp
    pushd /tmp
        tar zxf ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz
        cp ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl/rg ${INSTALL_DIR}/bin/
    popd
}


echoI "Install ripgrep (rg)"
if ! { type rg > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y ripgrep
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S ripgrep
    elif $IS_LINUX && ! $IS_SUDOER; then
        install_rg $INSTALL_PATH
    fi
fi


echoI "Install filezilla"
if ! { type filezilla > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y filezilla
    elif $IS_MAC; then
        brew install filezilla
    fi
fi


echoI "Install quicktile"
if ! { type quicktile > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt-get install -y python3 python3-pip python3-setuptools python3-gi python3-xlib python3-dbus gir1.2-glib-2.0 gir1.2-gtk-3.0 gir1.2-wnck-3.0
        sudo pip3 install https://github.com/ssokolow/quicktile/archive/master.zip
        if [ ! -L ~/.config/quicktile ]; then
            ln -s $(pwd)/quicktile.cfg ~/.config/
        fi
    fi
fi


echoI "Install nkf"
if ! { type nkf > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y nkf
    elif $IS_MAC; then
        brew install nkf
    fi
fi


echoI "Install autossh"
if ! { type autossh > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y autossh
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S autossh
    elif $IS_MAC; then
        brew install autossh
    fi
fi


echoI "Install gimp"
if $IS_DEBIAN && ! { type gimp >/dev/null 2>&1; } then
    if $IS_SUDOER; then
        sudo apt install -y gimp
    fi
elif $IS_ARCH && ! { type gimp >/dev/null 2>&1; } then
    if $IS_SUDOER; then
        yes | yay -S gimp
    fi
elif $IS_MAC && [ ! -d "/Applications/GIMP-2.10.app" ]; then
    brew install --cask gimp
fi


echoI "Install imagemagick"
if ! { type convert > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y imagemagick
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S imagemagick
    elif $IS_MAC; then
        brew install imagemagick
    fi
fi


echoI "Install textlint"
if ! { npm list --global | grep textlint >/dev/null 2>&1; } then
    if $IS_LINUX && $IS_SUDOER; then
        sudo npm install -g \
            textlint \
            textlint-rule-preset-ja-technical-writing \
            textlint-rule-ginger \
            textlint-rule-no-dead-link
    fi
fi


echoI "Install sshfs"
if ! { type sshfs > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y sshfs
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S sshfs
    elif $IS_MAC; then
        brew install sshfs
    fi
fi


echoI "Install mutagen"
if ! { type mutagen > /dev/null 2>&1; } then
    if $IS_LINUX && $IS_SUDOER; then
        MUTAGEN_VERSION="v0.17.0"
        wget -P /tmp https://github.com/mutagen-io/mutagen/releases/download/${MUTAGEN_VERSION}/mutagen_linux_amd64_${MUTAGEN_VERSION}.tar.gz
        pushd /usr/local/bin
        sudo tar zxf /tmp/mutagen_linux_amd64_${MUTAGEN_VERSION}.tar.gz
        popd
    fi
fi


echoI "Install trash-cli"
if ! { type trash > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y trash-cli
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S trash-cli
    fi
fi


echoI "Install discord"
if ! { type discord > /dev/null 2>&1; } then
    if $IS_ARCH && $IS_SUDOER; then
        yes | yay -S discord
    fi
fi

echoI "Install hackgen"
if `fc-list | grep HackGen >/dev/null 2>&1` then
    if $IS_ARCH && $IS_SUDOER; then
        yes | yay -S ttc-hackgen
    fi
fi


echoI "Finished"
