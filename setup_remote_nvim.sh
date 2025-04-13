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

export INSTALL_DIR="${HOME}/.local"
mkdir -p ${INSTALL_DIR}/bin
export PATH="${INSTALL_DIR}/bin:$PATH"

export SCRIPT_DIR=$(dirname $(realpath $0))


# --------------------------------------------------
# install node and npm
# --------------------------------------------------
if ! { type node > /dev/null 2>&1; } then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    nvm install 22

    # NODE_VERSION=v23.6.0
    # wget -O ${TMP_DIR}/node-${NODE_VERSION}-linux-x64.tar.xz https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz
    # tar Jxf ${TMP_DIR}/node-${NODE_VERSION}-linux-x64.tar.xz -C ${INSTALL_DIR}
    # ln -s ${INSTALL_DIR}/node-${NODE_VERSION}-linux-x64/bin/node ${INSTALL_DIR}/bin/node

    # check if node is installed
    if { type node > /dev/null 2>&1; } then
        echoI "-- node is installed."
        node -v  # v22.13.0
    else
        echoE "-- node is not installed."
        exit 1
    fi

    # check if npm is installed
    if { type npm > /dev/null 2>&1; } then
        echoI "-- npm is installed."
        npm -v  # 10.9.2
    else
        echoE "-- npm is not installed."
        exit 1
    fi
else
    echoI "-- node is already installed."
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
echoI "Install ctags"
if ! { type ctags > /dev/null 2>&1; } then
    # copy directly because building from source is too slow
    cp ${SCRIPT_DIR}/bin/ctags-universal ${INSTALL_DIR}/bin/ctags

    # check if ctags is installed
    if { type ctags > /dev/null 2>&1; } then
        echoI "-- ctags is installed."
    else
        echoE "-- ctags is not installed."
        exit 1
    fi
fi


# --------------------------------------------------
# install silversearcher-ag
# --------------------------------------------------
echoI "Install silversearcher-ag (ag)"
if ! { type ag > /dev/null 2>&1; } then
    # copy directly because building from source is too slow
    cp ${SCRIPT_DIR}/bin/ag ${INSTALL_DIR}/bin/ag
    mkdir -p ${INSTALL_DIR}/lib/x86_64-linux-gnu
    for lib in libpcre.so.3 libpcre.so.3.13.3; do
        cp ${SCRIPT_DIR}/lib/x86_64-linux-gnu/${lib} ${INSTALL_DIR}/lib/x86_64-linux-gnu/${lib}
    done
    export LD_LIBRARY_PATH=${INSTALL_DIR}/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

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
    RG_VERSION="14.1.1"
    wget https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz -P ${TMP_DIR}
    tar zxf ${TMP_DIR}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz -C ${INSTALL_DIR}
    ln -s ${INSTALL_DIR}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl/rg ${INSTALL_DIR}/bin/rg

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
# install vim-plug
# --------------------------------------------------
echoI "Install vim-plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# --------------------------------------------------
# install nvim
# --------------------------------------------------
echoI "Install nvim"
if ! { type nvim > /dev/null 2>&1; } then
    NVIM_VERSION="0.10.3"
    wget -P ${TMP_DIR} https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux64.tar.gz
    tar zxf ${TMP_DIR}/nvim-linux64.tar.gz -C ${INSTALL_DIR}
    ln -s ${INSTALL_DIR}/nvim-linux64/bin/nvim ${INSTALL_DIR}/bin/nvim

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

# --------------------------------------------------
# copy libjasson and libyaml
# --------------------------------------------------
mkdir -p ${INSTALL_DIR}/lib/x86_64-linux-gnu
for lib in libjansson.so.4 libjansson.so.4.13.0 libyaml-0.so.2 libyaml-0.so.2.0.6; do
    cp ${SCRIPT_DIR}/lib/x86_64-linux-gnu/${lib} ${INSTALL_DIR}/lib/x86_64-linux-gnu/${lib}
done


# --------------------------------------------------
# FINISH
# --------------------------------------------------
echoI "Complete!"
echoI "Please run the following command."
echo ""
echo "export PATH=\"${INSTALL_DIR}/bin:\$PATH\""
echo "export PATH=\"${HOME}/.deno/bin:\$PATH\""
echo "export LD_LIBRARY_PATH=\"${INSTALL_DIR}/lib/x86_64-linux-gnu:\$LD_LIBRARY_PATH\""
echo "source ${HOME}/.nvm/nvm.sh"
echo ""
echoI "You may need to change \`shell\`"
echo "    :set shell=/bin/bash"
echo ""
echoI "Run `nvim`"
