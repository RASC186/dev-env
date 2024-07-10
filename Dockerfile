FROM debian:12
ENV TERM=xterm-256color

# SET LOCALE

RUN apt-get update
RUN apt-get upgrade

RUN apt-get install -y locales 

RUN rm -rf /var/lib/apt/lists/* 

RUN localedef -i en_US -c -f UTF-8 -A \
  /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

# INSTALL NVIM DEPENDENCIES

RUN apt update
RUN apt upgrade

RUN apt install -y apt-utils pkg-config
RUN apt install -y git 
RUN apt install -y wget curl 
RUN apt install -y unzip 
RUN apt install -y ripgrep 
RUN apt install -y golang
RUN apt install -y rustc cargo
RUN apt install -y openjdk-17-jdk gradle maven 
RUN apt install -y lua5.4 luarocks
RUN apt install -y python3.11 python3.11-venv python3-pip
RUN apt install -y make cmake bear gdb 
RUN apt install -y latexmk texlive-full
RUN apt install -y xclip 
RUN apt install -y fuse
RUN apt install -y byacc bison 
RUN apt install -y automake autotools-dev build-essential  
RUN apt install -y libevent-dev libncurses5-dev 

# CREATE .CONFIG DIRECTIORY

RUN mkdir -p /root/.config/

# SET BASHRC

COPY ./config/bash/.bashrc /root/.bashrc

# INSTALL NVIM

RUN mkdir -p /opt/nvim/
ENV PATH="$PATH:/opt/nvim/" 

RUN curl -o /opt/nvim/nvim \
  -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
RUN chmod u+x /opt/nvim/nvim

COPY ./config/neovim/nvim/ /root/.config/nvim/

# INSTALL TMUX

RUN mkdir -p /tmp/tmux

RUN wget https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz \
  -P /tmp/tmux
RUN tar xzvf /tmp/tmux/tmux-3.3a.tar.gz -C /tmp/tmux

WORKDIR /tmp/tmux/tmux-3.3a/
RUN ./configure 
RUN make && make install

RUN rm -rf /tmp/tmux

COPY ./config/tmux/tmux/ /root/.config/tmux/

# SET WORKSPACE

RUN mkdir /root/workspace
WORKDIR /root/workspace
