#!/usr/bin/env bash

set -Ce

echoI () {
    echo -e "\e[32m$1\e[m"
}

echoE () {
    echo -e "\e[31m$1\e[m"
}

TMP_DIR=$(mktemp -d)
NJOBS=${NJOBS:-5}
GNU_MIRROR="https://ftp.jaist.ac.jp/pub/GNU"
export XDG_CONFIG_HOME=${HOME}/.config
if [ ! -d $XDG_CONFIG_HOME ]; then
    mkdir -p $XDG_CONFIG_HOME
fi

script_dir=$(dirname $(realpath $0))

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
    echoI "Linux"
    OS_ID=$(cat /etc/os-release | grep -E '^ID=' | sed -e 's/^ID=\(.*\)$/\1/')
    if [ "${OS_ID}" = "ubuntu" ]; then
        IS_DEBIAN=true
        echoI "Debian"
    elif [ "${OS_ID}" = "arch" ]; then
        IS_ARCH=true
        echoI "Arch"
    fi
else
    echoE "FAILURE: Unsupported OS."
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
        export INSTALL_PATH="${HOME}/local"
        export PATH="${INSTALL_PATH}/bin:$PATH"
    fi
fi

# install software
echoI "Install software"

function brew_install () {
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

function brew_install_cask () {
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


# install essential packages
if $IS_DEBIAN && $IS_SUDOER; then
    sudo apt-get update
    sudo apt-get install -y wget build-essential unzip
fi


# libraries
if $IS_LINUX && ! $IS_SUDOER; then
    if ! { type autoconf > /dev/null 2>&1; } then
        # build m4 (prerequisite of autoconf)
        M4_VERSION="1.4.19"
        wget -O ${TMP_DIR}/m4-${M4_VERSION}.tar.gz ${GNU_MIRROR}/m4/m4-${M4_VERSION}.tar.gz
        tar zxf ${TMP_DIR}/m4-${M4_VERSION}.tar.gz -C ${TMP_DIR}
        pushd ${TMP_DIR}/m4-${M4_VERSION}
            ./configure --prefix=${INSTALL_DIR}
            make -j ${NJOBS}
            make install
        popd

        # build autoconf (prerequisite of universal-ctags)
        AUTOCONF_VERSION="2.72"
        wget -O ${TMP_DIR}/autoconf-${AUTOCONF_VERSION}.tar.gz ${GNU_MIRROR}/autoconf/autoconf-${AUTOCONF_VERSION}.tar.gz
        tar zxf ${TMP_DIR}/autoconf-${AUTOCONF_VERSION}.tar.gz -C ${TMP_DIR}
        pushd ${TMP_DIR}/autoconf-${AUTOCONF_VERSION}
            ./configure --prefix=${INSTALL_DIR}
            make -j ${NJOBS}
            make install
        popd
    fi

    if ! { type automake > /dev/null 2>&1; } then
        # build automake (prerequisite of universal-ctags)
        AUTOMAKE_VERSION="1.16.5"
        wget -O ${TMP_DIR}/automake-${AUTOMAKE_VERSION}.tar.gz ${GNU_MIRROR}/automake/automake-${AUTOMAKE_VERSION}.tar.gz
        tar zxf ${TMP_DIR}/automake-${AUTOMAKE_VERSION}.tar.gz -C ${TMP_DIR}
        pushd ${TMP_DIR}/automake-${AUTOMAKE_VERSION}
            ./configure --prefix=${INSTALL_DIR}
            make -j ${NJOBS}
            make install
        popd
    fi

    if ! { type pkg-config > /dev/null 2>&1; } then
        # build pkg-config (prerequisite of universal-ctags)
        PKG_CONFIG_VERSION="0.29.2"
        wget -O ${TMP_DIR}/pkg-config-${PKG_CONFIG_VERSION}.tar.gz https://pkgconfig.freedesktop.org/releases/pkg-config-${PKG_CONFIG_VERSION}.tar.gz
        tar zxf ${TMP_DIR}/pkg-config-${PKG_CONFIG_VERSION}.tar.gz -C ${TMP_DIR}
        pushd ${TMP_DIR}/pkg-config-${PKG_CONFIG_VERSION}
            ./configure --prefix=${INSTALL_DIR} --with-internal-glib
            make -j ${NJOBS}
            make install
        popd
    fi

    # if ! { type gettext > /dev/null 2>&1; } then
    #     # build gettext (prerequisite of git)
    #     GETTEXT_VERSION="0.22.5"
    #     wget -O ${TMP_DIR}/gettext-${GETTEXT_VERSION}.tar.gz ${GNU_MIRROR}/gettext/gettext-${GETTEXT_VERSION}.tar.gz
    #     tar zxf ${TMP_DIR}/gettext-${GETTEXT_VERSION}.tar.gz -C ${TMP_DIR}
    #     pushd ${TMP_DIR}/gettext-${GETTEXT_VERSION}
    #         ./configure --prefix=${INSTALL_DIR}
    #         make -j ${NJOBS}
    #         make install
    #     popd
    # fi
fi


# install git
echoI "Install git"
if ! { type git > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt-get install -y git
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S git
    elif $IS_LINUX && ! $IS_SUDOER; then
        # # install zlib-devel if not installed
        # ZLIB_VERSION="1.3.1"
        # wget -P ${TMP_DIR} http://www.zlib.net/zlib-${ZLIB_VERSION}.tar.gz
        # tar zxf ${TMP_DIR}/zlib-${ZLIB_VERSION}.tar.gz -C ${TMP_DIR}
        # pushd ${TMP_DIR}/zlib-${ZLIB_VERSION}
        #     ./configure --prefix=${INSTALL_PATH}
        #     make -j ${NJOBS}
        #     make install
        # popd

        # GIT_VERSION="2.44.0"
        # wget -O ${TMP_DIR}/git-${GIT_VERSION}.tar.gz https://github.com/git/git/archive/refs/tags/v${GIT_VERSION}.tar.gz
        # tar zxf ${TMP_DIR}/git-${GIT_VERSION}.tar.gz -C ${TMP_DIR}
        # pushd ${TMP_DIR}/git-${GIT_VERSION}
        #     export CFLAGS="-I${INSTALL_PATH}/include"
        #     export CPPFLAGS="-I${INSTALL_PATH}/include"
        #     export LDFLAGS="-L${INSTALL_PATH}/lib"
        #     make configure
        #     ./configure --prefix=${INSTALL_PATH}
        #     make -j ${NJOBS}
        #     make install
        #     unset CFLAGS
        #     unset CPPFLAGS
        #     unset LDFLAGS
        # popd
        :  # do nothing because git is already installed
    elif $IS_MAC; then
        brew install git
    fi

    # check if git is installed
    if { type git > /dev/null 2>&1; } then
        echoI "-- git is installed."
    else
        echoE "-- git is not installed."
        exit 1
    fi
else
    echoI "-- git is already installed."
fi


echoI "Install curl"
if ! { type curl >/dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y curl
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S curl
    elif $IS_LINUX && ! $IS_SUDOER; then
        CURL_VERSION="8.6.0"
        wget -P ${TMP_DIR} https://github.com/stunnel/static-curl/releases/download/${CURL_VERSION}-1/curl-linux-x86_64-${CURL_VERSION}.tar.xz
        if [ ! -d ${INSTALL_PATH}/bin ]; then
            mkdir -p ${INSTALL_PATH}/bin
        fi
        tar Jxf ${TMP_DIR}/curl-linux-x86_64-${CURL_VERSION}.tar.xz -C ${INSTALL_PATH}/bin
    elif $IS_MAC; then
        brew install curl
    fi
    
    # check if curl is installed
    if { type curl > /dev/null 2>&1; } then
        echoI "-- curl is installed."
    else
        echoE "-- curl is not installed."
        exit 1
    fi
else
    echoI "-- curl is already installed."
fi


# --------------------------------------------------
# install python3 (anaconda)
# --------------------------------------------------
echoI "Install miniconda3"
conda_dst="${HOME}/miniconda3"
export PATH=$conda_dst/bin:$PATH
if [ ! -d $conda_dst ]; then
    echo "install miniconda3 ...."
    if $IS_MAC; then
        conda_installer=Miniconda3-latest-MacOSX-x86_64.sh
    elif $IS_LINUX; then
        conda_installer=Miniconda3-latest-Linux-x86_64.sh
    fi
    wget https://repo.anaconda.com/miniconda/$conda_installer -P ${TMP_DIR}
    bash ${TMP_DIR}/$conda_installer -b -p $conda_dst

    echo "update conda ...."
    conda update -y -n base -c defaults conda
else
    echo "miniconda3 already exists."
fi


# --------------------------------------------------
# install zsh
# --------------------------------------------------
function build_zsh_from_source () {
    INSTALL_DIR=$1

    # # install ncurses (not necessary if installed by conda)
    # NCURSES_VERSION="6.2"
    # wget -O ${TMP_DIR}/ncurses-${NCURSES_VERSION}.tar.gz -nc ${GNU_MIRROR}/ncurses/ncurses-${NCURSES_VERSION}.tar.gz
    # tar zxf ${TMP_DIR}/ncurses-${NCURSES_VERSION}.tar.gz -C ${TMP_DIR}
    # pushd ${TMP_DIR}/ncurses-${NCURSES_VERSION}
    #     export CXXFLAGS=' -fPIC'
    #     export CFLAGS=' -fPIC'
    #     ./configure --prefix=$INSTALL_DIR --enable-shared
    #     make -j ${NJOBS}
    #     make install
    # popd

    # install zsh
    ZSH_VERSION="5.9"
    wget -O ${TMP_DIR}/zsh-${ZSH_VERSION}.tar.xz -nc https://www.zsh.org/pub/zsh-${ZSH_VERSION}.tar.xz
    tar xf ${TMP_DIR}/zsh-${ZSH_VERSION}.tar.xz -C ${TMP_DIR}
    pushd ${TMP_DIR}/zsh-${ZSH_VERSION}
        # export PATH=$INSTALL_PATH/bin:$PATH
        # export LD_LIBRARY_PATH=$INSTALL_PATH/lib:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
        # export CFLAGS=-I$INSTALL_PATH/include
        # export CPPFLAGS=-I$INSTALL_PATH/include
        # export LDFLAGS=-L$INSTALL_PATH/lib
        export CFLAGS=-I${HOME}/miniconda3/include
        export CPPFLAGS=-I${HOME}/miniconda3/include
        export LDFLAGS=-L${HOME}/miniconda3/lib
        ./configure --prefix=$INSTALL_DIR --enable-shared
        make -j ${NJOBS}
        make install
        unset CFLAGS
        unset CPPFLAGS
        unset LDFLAGS
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
        export PATH=${PATH:+$PATH:}$INSTALL_PATH/bin
        export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$INSTALL_PATH/lib
        export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}${HOME}/miniconda3/lib
    elif $IS_MAC; then
        brew install zsh
        echo "change default shell to zsh...."
        sudo sh -c "echo $(which zsh) >> /etc/shells"
        chsh -s $(which zsh)
    fi
fi

# create symlink to zshrc
if [ ! -L ~/.zshrc ]; then
    echoI "create symbolic link to ~/.zshrc"
    ln -s ${script_dir}/zshrc ~/.zshrc
fi

# load zshrc in zsh shell
export LD_LIBRARY_PATH=${HOME}/miniconda3/lib:${LD_LIBRARY_PATH}
zsh -c "source ~/.zshrc"


# --------------------------------------------------
# install node
# --------------------------------------------------
echoI "Install nodejs for coc.nvim"
if ! { type node > /dev/null 2>&1; } then
    if $IS_LINUX && ! $IS_SUDOER; then
        NODE_VERSION=v20.11.1
        wget -O ${TMP}/node-${NODE_VERSION}-linux-x64.tar.xz https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz
        tar Jxf ${TMP}/node-${NODE_VERSION}-linux-x64.tar.xz -C ${INSTALL_PATH}
        ln -s ${INSTALL_PATH}/node-${NODE_VERSION}-linux-x64/bin/node ${INSTALL_PATH}/bin/node
    elif $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y nodejs npm
        sudo npm install n -g -y
        sudo n stable
        sudo apt purge -y nodejs npm
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S nodejs npm
    fi

    # check if node is installed
    if { type node > /dev/null 2>&1; } then
        echoI "-- node is installed."
    else
        echoE "-- node is not installed."
        exit 1
    fi
else
    echoI "-- node is already installed."
fi


# --------------------------------------------------
# install nvim
# --------------------------------------------------
echoI "Install nvim"
if ! { type nvim > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y neovim
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S -y neovim
    elif $IS_LINUX && ! $IS_SUDOER; then
        NVIM_VERSION="0.9.5"
        wget -P ${TMP_DIR} https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux64.tar.gz
        tar zxf ${TMP_DIR}/nvim-linux64.tar.gz -C ${INSTALL_PATH}
        ln -s ${INSTALL_PATH}/nvim-linux64/bin/nvim ${INSTALL_PATH}/bin/nvim
    elif $IS_MAC; then
        brew install neovim
    fi

    # check if nvim is installed
    if { type nvim > /dev/null 2>&1; } then
        echoI "-- nvim is installed."
    else
        echoE "-- nvim is not installed."
        exit 1
    fi
else
    echoI "-- nvim is already installed."
fi

# /usr/bin/pip3 install pynvim jedi flake8 isort black jedi-language-server  # install to ~/.local/bin
if ! { conda env list | grep neovim > /dev/null 2>&1; } then
    echo "create conda env for neovim...."
    conda create -y --name neovim python=3.10
    export SHELL=$(which bash)
    . ${HOME}/miniconda3/etc/profile.d/conda.sh
    conda activate neovim
    pip install pynvim jedi jedi-language-server flake8 isort black black-macchiato
    conda deactivate

    for bin in isort black black-macchiato flake8 jedi-language-server; do
        ln -s ${HOME}/miniconda3/envs/neovim/bin/${bin} ${INSTALL_PATH}/bin/${bin}
    done

    # check if isort black flake8 jedi-language-server are installed
    if { type isort > /dev/null 2>&1; } && { type black > /dev/null 2>&1; } && { type flake8 > /dev/null 2>&1; } && { type jedi-language-server > /dev/null 2>&1; } then
        echoI "-- isort black flake8 jedi-language-server are installed."
    else
        echoE "-- isort black flake8 jedi-language-server are not installed."
        exit 1
    fi
else
    echo "conda neovim env already exists."
fi

if [ ! -L ${XDG_CONFIG_HOME}/nvim ]; then
    echoI "create symbolic link to ~/.config/nvim" 
    ln -s ${script_dir}/nvim ${XDG_CONFIG_HOME}/
fi


# --------------------------------------------------
# install deno
# --------------------------------------------------
echoI "Install deno"
export PATH="${HOME}/.deno/bin:$PATH"
if ! { type deno > /dev/null 2>&1; } then
    curl -fsSL https://deno.land/install.sh | sh

    # check if deno is installed
    if { type deno > /dev/null 2>&1; } then
        echoI "-- deno is installed."
    else
        echoE "-- deno is not installed."
        exit 1
    fi
else
    echoI "-- deno is already installed."
fi


# --------------------------------------------------
# install ctags
# --------------------------------------------------
function build_universal_ctags_from_source () {
    INSTALL_DIR=$1
    CTAGS_VERSION="6.1.0"

    wget -O ${TMP_DIR}/universal-ctags-${CTAGS_VERSION}.tar.gz https://github.com/universal-ctags/ctags/releases/download/v${CTAGS_VERSION}/universal-ctags-${CTAGS_VERSION}.tar.gz
    tar zxf ${TMP_DIR}/universal-ctags-${CTAGS_VERSION}.tar.gz -C ${TMP_DIR}
    pushd ${TMP_DIR}/universal-ctags-${CTAGS_VERSION}
        ./autogen.sh
        ./configure --prefix=${INSTALL_DIR}
        make -j ${NJOBS}
        make install # may require extra privileges depending on where to install
    popd
}

echoI "Install ctags"
if ! { type ctags > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y universal-ctags
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S universal-ctags
    elif $IS_LINUX && ! $IS_SUDOER; then
        build_universal_ctags_from_source $INSTALL_PATH
    elif $IS_MAC; then
        brew install ctags
    fi
fi


# --------------------------------------------------
# install silversearcher-ag
# --------------------------------------------------
function build_ag_from_source () {
    INSTALL_DIR=$1
    AG_VERSION="2.2.0"
    PCRE_VERSION="8.45"

    # install pcre (not pcre2)
    # ref: https://github.com/ggreer/the_silver_searcher/issues/341#issuecomment-724997919
    wget --content-disposition -P ${TMP_DIR} https://sourceforge.net/projects/pcre/files/pcre/${PCRE_VERSION}/pcre-${PCRE_VERSION}.tar.gz/download
    tar zxf ${TMP_DIR}/pcre-${PCRE_VERSION}.tar.gz -C ${TMP_DIR}
    pushd ${TMP_DIR}/pcre-${PCRE_VERSION}
        PKG_CONFIG_PATH="${HOME}/miniconda3/lib/pkgconfig/:${INSTALL_DIR}/lib/pkgconfig/:${PKG_CONFIG_PATH}" \
        ./configure --prefix=$INSTALL_DIR --enable-unicode-properties
        make -j ${NJOBS}
        make install
    popd

    # install ag
    wget -P ${TMP_DIR} https://geoff.greer.fm/ag/releases/the_silver_searcher-${AG_VERSION}.tar.gz
    tar zxf ${TMP_DIR}/the_silver_searcher-${AG_VERSION}.tar.gz -C ${TMP_DIR}
    pushd ${TMP_DIR}/the_silver_searcher-${AG_VERSION}
        # export LD_LIBRARY_PATH=${INSTALL_DIR}/lib:$LD_LIBRARY_PATH
        # export LD_LIBRARY_PATH=$INSTALL_DIR/lib:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
        # export C_INCLUDE_PATH=${HOME}/miniconda3/include:${INSTALL_DIR}/include:$C_INCLUDE_PATH
        export PKG_CONFIG_PATH="${HOME}/miniconda3/lib/pkgconfig:${INSTALL_DIR}/lib/pkgconfig:${PKG_CONFIG_PATH}"
        export LDFLAGS="-L${HOME}/miniconda3/lib"
        export CFLAGS="-I${HOME}/miniconda3/include -I${INSTALL_DIR}/include -fcommon -D_GNU_SOURCE -lpthread"
        ./configure --prefix=$INSTALL_DIR
        make -j ${NJOBS}
        make install
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

    # check if ag is installed
    if { type ag > /dev/null 2>&1; } then
        echoI "-- ag is installed."
    else
        echoE "-- ag is not installed."
        exit 1
    fi
else
    echoI "-- ag is already installed."
fi


# --------------------------------------------------
# install ripgrep
# --------------------------------------------------
echoI "Install ripgrep (rg)"
if ! { type rg > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y ripgrep
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S ripgrep
    elif $IS_LINUX && ! $IS_SUDOER; then
        RG_VERSION="13.0.0"
        wget https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz -P ${TMP_DIR}
        tar zxf ${TMP_DIR}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz -C ${INSTALL_PATH}
        ln -s ${INSTALL_PATH}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl/rg ${INSTALL_PATH}/bin/rg
    elif $IS_MAC; then
        brew install ripgrep
    fi

    # check if rg is installed
    if { type rg > /dev/null 2>&1; } then
        echoI "-- rg is installed."
    else
        echoE "-- rg is not installed."
        exit 1
    fi
else
    echoI "-- rg is already installed."
fi


# --------------------------------------------------
# install textlint
# --------------------------------------------------
# echoI "Install textlint"
# if ! { npm list --global | grep textlint >/dev/null 2>&1; } then
#     if $IS_LINUX && $IS_SUDOER; then
#         sudo npm install -g \
#             textlint \
#             textlint-rule-preset-ja-technical-writing \
#             textlint-rule-ginger \
#             textlint-rule-no-dead-link
#     fi
# fi


# install all pluging in nvim
# export PYTHON3_HOST_PROG=${HOME}/miniconda3/envs/neovim/bin/python
# nvim -u ${script_dir}/nvim/plug.vim -c "q" -c "q"
# nvim -c "PlugInstall" -c "q" -c "q"


function build_tmux_from_source () {
    INSTALL_DIR=$1
    # OPENSSL_VERSION="3.0.9"
    LIBEVENT_VERSION="2.1.12-stable"
    TMUX_VERSION="3.1b"

    # install openssl
    # wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz -P ${TMP_DIR}
    # tar zxf ${TMP_DIR}/openssl-${OPENSSL_VERSION}.tar.gz -C ${TMP_DIR}
    # pushd ${TMP_DIR}/openssl-${OPENSSL_VERSION}
    #     ./config --prefix=$INSTALL_DIR --openssldir=$INSTALL_DIR shared
    #     make -j ${NJOBS}
    #     make install
    # popd

    # install libevent
    if ! { ldconfig -p | grep libevent > /dev/null 2>&1; } then
        wget -P ${TMP_DIR} https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}/libevent-${LIBEVENT_VERSION}.tar.gz --no-check-certificate
        tar zxf ${TMP_DIR}/libevent-${LIBEVENT_VERSION}.tar.gz -C ${TMP_DIR}
        pushd ${TMP_DIR}/libevent-${LIBEVENT_VERSION}
            export PKG_CONFIG_PATH="${HOME}/miniconda3/lib/pkgconfig:${PKG_CONFIG_PATH}"
            ./configure --prefix=$INSTALL_DIR
            make -j ${NJOBS}
            make install
        popd
    fi

    # install tmux
    wget -P ${TMP_DIR} https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz --no-check-certificate
    tar zxf ${TMP_DIR}/tmux-${TMUX_VERSION}.tar.gz -C ${TMP_DIR}
    pushd ${TMP_DIR}/tmux-${TMUX_VERSION}
        export PKG_CONFIG_PATH="${HOME}/miniconda3/lib/pkgconfig:${INSTALL_DIR}/lib/pkgconfig:${PKG_CONFIG_PATH}"
        export CFLAGS="-I${HOME}/miniconda3/include -I/${INSTALL_DIR}/include $CFLAGS"
        export CPPFLAGS="-I${HOME}/miniconda3/include -I/${INSTALL_DIR}/include $CPPFLAGS"
        export LDFLAGS="-L${HOME}/miniconda3/lib -L${INSTALL_DIR}/lib64 $LDFLAGS"
        ./configure --prefix=$INSTALL_DIR
        make -j ${NJOBS}
        make install
        unset CFLAGS
        unset CPPFLAGS
        unset LDFLAGS
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

    # check if tmux is installed
    if { type tmux > /dev/null 2>&1; } then
        echoI "-- tmux is installed."
    else
        echoE "-- tmux is not installed."
        exit 1
    fi
else
    echoI "-- tmux is already installed."
fi

if [ ! -L ~/.tmux.conf ]; then
    echo "create symbolic link to ~/.tmux.conf" 
    ln -s ${script_dir}/tmux.conf ~/.tmux.conf
fi


function build_imagemagick_from_source () {
    INSTALL_DIR=$1
    IM_VERSION="7.1.1-29"

    wget -P ${TMP_DIR} https://imagemagick.org/archive/ImageMagick-${IM_VERSION}.tar.gz
    tar zxf ${TMP_DIR}/ImageMagick-${IM_VERSION}.tar.gz -C ${TMP_DIR}
    pushd ${TMP_DIR}/ImageMagick-${IM_VERSION}
        ./configure --prefix=$INSTALL_DIR
        make -j ${NJOBS}
        make install
    popd
}


echoI "Install imagemagick"
if ! { type convert > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y imagemagick
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S imagemagick
    elif $IS_MAC; then
        brew install imagemagick
    elif $IS_LINUX && ! $IS_SUDOER; then
        build_imagemagick_from_source $INSTALL_PATH
    fi
fi


echoI "Install filezilla"
if ! { type filezilla > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y filezilla
    elif $IS_MAC; then
        brew install filezilla
    elif $IS_LINUX && ! $IS_SUDOER; then
        echoI "-- filezilla from source is not supported. skip."
    fi
else
    echoI "-- filezilla is already installed. skip."
fi


echoI "Install quicktile"
if ! { type quicktile > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt-get install -y python3 python3-pip python3-setuptools python3-gi python3-xlib python3-dbus gir1.2-glib-2.0 gir1.2-gtk-3.0 gir1.2-wnck-3.0
        sudo pip3 install https://github.com/ssokolow/quicktile/archive/master.zip
        if [ ! -L ~/.config/quicktile ]; then
            echo ln -s ${script_dir}/quicktile.cfg ~/.config/
        fi
    elif $IS_DEBIAN && ! $IS_SUDOER; then
        echoI "-- quicktile from source is not supported. skip."
    fi
fi


echoI "Install nkf"
if ! { type nkf > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y nkf
    elif $IS_MAC; then
        brew install nkf
    elif $IS_LINUX && ! $IS_SUDOER; then
        echoI "-- nkf from source is not supported. skip."
    fi
fi


function build_autossh_from_source () {
    INSTALL_DIR=$1
    AUTOSSH_VERSION="1.4f"
    wget -P ${TMP_DIR} https://github.com/Autossh/autossh/releases/download/v${AUTOSSH_VERSION}/autossh-${AUTOSSH_VERSION}.tgz
    tar zxf ${TMP_DIR}/autossh-${AUTOSSH_VERSION}.tgz -C ${TMP_DIR}
    pushd ${TMP_DIR}/autossh-${AUTOSSH_VERSION}
        ./configure --prefix=$INSTALL_DIR
        make -j ${NJOBS}
        make install
    popd
}


echoI "Install autossh"
if ! { type autossh > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y autossh
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S autossh
    elif $IS_MAC; then
        brew install autossh
    elif $IS_LINUX && ! $IS_SUDOER; then
        build_autossh_from_source $INSTALL_PATH
    fi

    # check if autossh is installed
    if { type autossh > /dev/null 2>&1; } then
        echoI "-- autossh is installed."
    else
        echoE "-- autossh is not installed."
        exit 1
    fi
else
    echoI "-- autossh is already installed."
fi


echoI "Install gimp"
if $IS_DEBIAN && ! { type gimp >/dev/null 2>&1; } then
    if $IS_SUDOER; then
        sudo apt install -y gimp
    else
        echoI "-- build gimp from source is not supported. skip."
    fi
elif $IS_ARCH && ! { type gimp >/dev/null 2>&1; } then
    if $IS_SUDOER; then
        yes | yay -S gimp
    else
        echoI "-- build gimp from source is not supported. skip."
    fi
elif $IS_MAC && [ ! -d "/Applications/GIMP-2.10.app" ]; then
    brew install --cask gimp
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
    if $IS_LINUX; then
        MUTAGEN_VERSION="v0.17.5"
        wget -P ${TMP_DIR} https://github.com/mutagen-io/mutagen/releases/download/${MUTAGEN_VERSION}/mutagen_linux_amd64_${MUTAGEN_VERSION}.tar.gz
        tar zxf ${TMP_DIR}/mutagen_linux_amd64_${MUTAGEN_VERSION}.tar.gz -C ${INSTALL_PATH}/bin
    elif $IS_MAC; then
        echoI "-- mutagen for mac is not supported. skip."
    fi
else
    echoI "-- mutagen is already installed. skip."
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
if ! { type fc-list > /dev/null 2>&1; } then
    echoE "-- fc-list is not installed. skip installing hackgen."
elif `fc-list | grep HackGen >/dev/null 2>&1`; then
    if $IS_ARCH && $IS_SUDOER; then
        yes | yay -S ttc-hackgen
    elif $IS_LINUX; then
        HACKGEN_VERSION="2.9.0"
        wget -P ${TMP_DIR} https://github.com/yuru7/HackGen/releases/download/v${HACKGEN_VERSION}/HackGen_NF_v${HACKGEN_VERSION}.zip
        unzip ${TMP_DIR}/HackGen_NF_v${HACKGEN_VERSION}.zip -d ${TMP_DIR}
        if [ ! -d ${HOME}/.local/share/fonts ]; then
            mkdir -p ${HOME}/.local/share/fonts
        fi
        cp -r ${TMP_DIR}/HackGen_NF_v${HACKGEN_VERSION} ~/.fonts/HackGen_NF
    fi

    fc-cache -fv

    # check if HackGen is installed
    if `fc-list | grep HackGen >/dev/null 2>&1`; then
        echoI "-- HackGen is installed."
    else
        echoE "-- HackGen is not installed."
        exit 1
    fi
else
    echoI "-- HackGen is already installed."
fi


function build_xclip_from_source () {
    # does not work
    INSTALL_DIR=$1

    # MACROS_VERSION="1.20.0"
    # wget -P ${TMP_DIR} https://gitlab.freedesktop.org/xorg/util/macros/-/archive/util-macros-${MACROS_VERSION}/macros-util-macros-${MACROS_VERSION}.tar.gz
    # tar zxf ${TMP_DIR}/macros-util-macros-${MACROS_VERSION}.tar.gz -C ${TMP_DIR}
    # pushd ${TMP_DIR}/macros-util-macros-${MACROS_VERSION}
    #     ./autogen.sh
    #     ./configure --prefix=$INSTALL_DIR
    #     make -j ${NJOBS}
    #     make install
    # popd

    LIBX11_VERSION="1.8.7"
    wget -P ${TMP_DIR} https://gitlab.freedesktop.org/xorg/lib/libx11/-/archive/libX11-${LIBX11_VERSION}/libx11-libX11-${LIBX11_VERSION}.tar.gz
    tar zxf ${TMP_DIR}/libx11-libX11-${LIBX11_VERSION}.tar.gz -C ${TMP_DIR}
    pushd ${TMP_DIR}/libx11-libX11-${LIBX11_VERSION}
        export PKG_CONFIG_PATH="${HOME}/miniconda3/lib/pkgconfig:${INSTALL_DIR}/lib/pkgconfig:${PKG_CONFIG_PATH}"
        ./autogen.sh
        ./configure --prefix=$INSTALL_DIR
        make -j ${NJOBS}
        make install
    popd


    XCLIP_VERSION="0.13"
    wget -P ${TMP_DIR} https://github.com/astrand/xclip/archive/refs/heads/master.zip
    unzip ${TMP_DIR}/master.zip -d ${TMP_DIR}
    pushd ${TMP_DIR}/xclip-master
        autoreconf
        ./configure --prefix=$INSTALL_DIR
        make -j ${NJOBS}
        make install
    popd
}

# to save yanked to clipboard in neovim
echoI "Install xclip"
if ! { type xclip > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        sudo apt install -y xclip
    elif $IS_ARCH && $IS_SUDOER; then
        yes | yay -S xclip
    elif $IS_LINUX && ! $IS_SUDOER; then
        # build_xclip_from_source $INSTALL_PATH
        :
    fi
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


# install nvtop
echoI "Install nvtop"
if ! { type nvtop > /dev/null 2>&1; } then
    if $IS_DEBIAN && $IS_SUDOER; then
        # sudo apt install nvtop
        :
    fi
fi


echoI "Finished"
rm -rf ${TMP_DIR}
