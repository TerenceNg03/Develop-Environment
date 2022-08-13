#!/bin/bash
# Install and set zsh
if [[ ! -z `which zsh` ]];
then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/conda-zsh-completion
        cp zshrc ${HOME}/.zshrc
else
        echo 'No having zsh, skip installation'
fi

# Install vim
mkdir -p $HOME/node
export PATH=$PATH:${HOME}/node/bin
curl -sL install-node.vercel.app/lts | bash -s -- --prefix=$HOME/node --yes
corepack enable
curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp vimrc ${HOME}/.vimrc
vim +PlugInstall +qall

# setup coc
cd ${HOME}/.vim/plugged/coc.nvim && yarn install

