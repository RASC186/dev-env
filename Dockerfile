FROM debian:12
ENV TERM=xterm-256color

# SET LOCALE

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y locales 

RUN rm -rf /var/lib/apt/lists/* 

RUN localedef -i en_US -c -f UTF-8 -A \
  /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

# INSTALL PACKAGES

RUN apt update
RUN apt upgrade -y

RUN apt install -y apt-utils pkg-config

RUN apt install -y git 
RUN apt install -y wget 
RUN apt install -y unzip 
RUN apt install -y xclip 

RUN apt install -y bear 
RUN apt install -y fuse
RUN apt install -y ripgrep 

RUN apt install -y make cmake gdb 
RUN apt install -y lua5.4 luarocks
RUN apt install -y python3.11 python3.11-venv python3-pip
RUN apt install -y rustc cargo
RUN apt install -y golang
RUN apt install -y openjdk-17-jdk gradle maven 
RUN apt install -y latexmk texlive-full

RUN apt install -y byacc bison 
RUN apt install -y libevent-dev libncurses5-dev 
RUN apt install -y automake autotools-dev build-essential  

# CREATE .CONFIG DIRECTIORY

RUN mkdir -p /root/.config/

# SET BASHRC

COPY ./config/bash/.bashrc /root/.bashrc

# INSTALL NVIM

RUN mkdir -p /opt/nvim/
ENV PATH="$PATH:/opt/nvim/" 

RUN wget -O /opt/nvim.tar.gz \
  https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz
RUN tar -xzvf /opt/nvim.tar.gz --directory /opt/
RUN rm -f /opt/nvim.tar.gz
RUN ln -s /opt/nvim-linux64/bin/nvim /usr/bin/nvim
COPY ./config/neovim/nvim/ /root/.config/nvim/

# INSTALL TMUX

RUN apt install -y tmux
COPY ./config/tmux/tmux/ /root/.config/tmux/
RUN git clone https://github.com/tmux-plugins/tpm.git \
  /root/.config/tmux/plugins/tpm/
RUN echo "\nPATH=$PATH" >> /root/.profile

# SET WORKSPACE

RUN mkdir /root/workspace
WORKDIR /root/workspace
