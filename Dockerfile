FROM ubuntu:24.04

RUN apt-get update \
  && apt-get -y satisfy \
  "zsh (>= 5)" \
  "wget (>= 1.21)" \
  "curl (>= 8.5)" \
  "git (>= 2.43)" \
  && rm -rf /var/lib/apt/lists/*

RUN usermod -d /home/smee -m ubuntu \
  && usermod -l smee ubuntu \
  && chsh -s /usr/bin/zsh smee

USER 1000:1000

ENV HISTFILE=/home/smee/history/.zsh_history
RUN mkdir -p /home/smee/history \
  && touch $HISTFILE \
  && chmod 600 $HISTFILE

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.2.1/zsh-in-docker.sh)"

VOLUME /work

WORKDIR /work

ENTRYPOINT ["/usr/bin/zsh", "-l"]
