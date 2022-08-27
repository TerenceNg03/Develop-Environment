From ubuntu:20.04
USER root
RUN apt update && apt upgrade -y
RUN apt install git curl -y
RUN rm -rf /var/lib/apt/lists/*
RUN useradd -ms /bin/bash terenceng
USER terenceng
WORKDIR /home/terenceng
COPY --chown=terenceng:terenceng ./* /home/terenceng/
RUN bash -c /home/terenceng/install.sh
# Entry point for zsh
ENTRYPOINT /bin/zsh
