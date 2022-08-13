From ubuntu:20.04
USER root
RUN apt update && apt upgrade -y

# Install and set zsh
RUN apt install zsh curl git autojump fzf vim -y
RUN chsh -s $(which zsh)
WORKDIR /root
COPY install.sh /root/install.sh
COPY vimrc /root/.vimrc
COPY zshrc /root/.zshrc
RUN bash -c /root/install.sh

# Entry point for zsh
ENTRYPOINT /bin/zsh
