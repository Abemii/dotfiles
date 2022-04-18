# create neovim docker env
FROM ubuntu:20.04

ARG MAINTAINER
ARG JOBS

LABEL maintainer="${MAINTAINER}"

RUN apt-get update && \
    apt-get install -y software-properties-common
RUN add-apt-repository ppa:neovim-ppa/stable -y && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    wget \
    gcc \
    cmake \
    libtinfo5 \
    libncurses5-dev \
    libncursesw5-dev \
    git \
    locales \
    neovim \
    nodejs \
    npm \
    patch \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    python-is-python3 \
    ripgrep \
    silversearcher-ag \
    tmux \
    universal-ctags \
    zsh \
    jq
# install latest nodejs
RUN npm i -g n && \
    n latest && \
    apt-get purge nodejs npm -y
# set locale
RUN locale-gen en_US.UTF-8
ENV LANG="en_US.UTF-8" LANGUAGE="en_US:ja" LC_ALL="en_US.UTF-8"
# install ccls
# RUN LLVM_VERSION="13.0.1" CCLS_VERSION="0.20210330" && \
#     cd /usr/src && \
#     git clone --depth=1 -b ${CCLS_VERSION} --recursive https://github.com/MaskRay/ccls && \
#     cd ccls && \
#     wget -c https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/clang+llvm-${LLVM_VERSION}-x86_64-linux-gnu-ubuntu-18.04.tar.xz && \
#     tar xf clang+llvm-${LLVM_VERSION}-x86_64-linux-gnu-ubuntu-18.04.tar.xz && \
#     rm clang+llvm-${LLVM_VERSION}-x86_64-linux-gnu-ubuntu-18.04.tar.xz && \
#     cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-${LLVM_VERSION}-x86_64-linux-gnu-ubuntu-18.04 -DCMAKE_CXX_FLAGS=-fno-gnu-unique && \
#     cmake --build Release --target install -j${JOBS:-1}
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    add-apt-repository "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-14 main" && \
    apt-get update && \
    apt-get install -y \
    clang-14 \
    libclang-14-dev
RUN CCLS_VERSION="master" && \
    cd /usr/src && \
    git clone --depth=1 -b ${CCLS_VERSION} --recursive https://github.com/MaskRay/ccls && \
    cd ccls && \
    cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_PREFIX_PATH=/usr/lib/llvm-14 \
        -DLLVM_INCLUDE_DIR=/usr/lib/llvm-14/include \
        -DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-14 && \
    cmake --build Release --target install -j${JOBS:-1}
RUN apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*
# install pythoh packages
RUN pip install --upgrade \
    pynvim \
    jedi \
    jedi-language-server \
    flake8 \
    isort \
    black \
    black-macchiato \
    docformatter
# custom settings for neovim
RUN git clone --depth=1 https://github.com/Abemii/dotfiles.git /tmp/dotfiles && \
    mv /tmp/dotfiles/nvim ~/.config/ && \
    mv /tmp/dotfiles/zshrc ~/.zshrc && \
    rm -rf /tmp/dotfiles
RUN curl -fLo ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN nvim --headless -u ~/.config/nvim/plug.vim +PlugInstall +qa
RUN nvim --headless -u ~/.config/nvim/plug.vim +'CocInstall -sync coc-json coc-highlight coc-jedi coc-diagnostic coc-vimlsp coc-sh coc-lua' +qa
RUN nvim --headless -u ~/.config/nvim/plug.vim +'TSInstallSync all' +qa
RUN mv ~/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.tmp.json && \
    jq < ~/.config/nvim/coc-settings.tmp.json \
    '."jedi.executable.command" = "jedi-language-server" | \
    ."diagnostic-languageserver.linters".flake8.command = "flake8" | \
    ."diagnostic-languageserver.formatters".black.command = "black" | \
    ."diagnostic-languageserver.formatters".isort.command = "isort" | \
    ."diagnostic-languageserver.formatters".docformatter.command = "docformatter"' \
    > ~/.config/nvim/coc-settings.json
ENV ANACONDA_PATH="" PYTHON3_HOST_PROG="python"
ENV TERM=xterm-256color
RUN ["zsh", "-ic", "source ~/.zshrc"]
RUN chmod -R 777 /root
ENTRYPOINT ["nvim"]
