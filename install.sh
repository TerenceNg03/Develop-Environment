#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
# install homebrew
if ! command -v brew &> /dev/null
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew_install(){
    brew list $1 &> /dev/null || brew install $1
}
# Install and set zsh
brew_install zsh

if [[ ! -d ${HOME}/.oh-my-zsh ]];
then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/conda-zsh-completion
    cp zshrc ${HOME}/.zshrc
fi

# Install autojump
brew_install autojump

# Install fzf
brew_install fzf
brew_install bat
brew_install ripgrep
brew_install fd

# Install font
FONT_FILE="Droid Sans Mono for Powerline Nerd Font Complete.otf"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    mkdir -p ${HOME}/.local/share/fonts
    if [[ ! -f "${HOME}/.local/share/fonts/$FONT_FILE" ]];
    then
        cd ${HOME}/.local/share/fonts && curl -fLo $FONT_FILE https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
        cd $SCRIPT_DIR
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    if [[ ! -f "${HOME}/Library/Fonts/$FONT_FILE" ]];
    then
        cd ${HOME}/Library/Fonts && curl -fLo $FONT_FILE https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
        cd $SCRIPT_DIR
    fi
fi

# Install vim
brew_install nvim
brew_install curl

if ! command -v node &> /dev/null
then
    mkdir -p $HOME/node
    export PATH=$PATH:${HOME}/node/bin
    curl -sL install-node.vercel.app/lts | bash -s -- --prefix=$HOME/node --yes
    corepack enable
fi
if [[ ! -f ${HOME}/.local/share/nvim/site/autoload/plug.vim ]];
then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi
mkdir -p ${HOME}/.config/nvim
cp vimrc ${HOME}/.config/nvim/init.vim
nvim +PlugClean +PlugInstall +qall

# setup coc
cd ${HOME}/.vim/plugged/coc.nvim && yarn install
