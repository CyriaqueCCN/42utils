# syntax=docker/dockerfile:1
FROM debian:latest

RUN mkdir /rainfall
RUN apt-get update && apt-get install -y openssh-server openssh-client sshpass python3 python3-pip zsh git curl ltrace file xxd gdb vim
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN echo "cd /rainfall/" >> /root/.zshrc
RUN echo 'export PATH=/usr/bin:/root/.local/bin:$PATH' >> /root/.zshrc
RUN pip3 install --upgrade pip
RUN pip3 install pwntools
