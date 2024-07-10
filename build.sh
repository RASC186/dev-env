#!/usr/bin/env bash

# CREATE CONFIG DIRECTORY

config_dirpath="./config"

if ! [ -d "${config_dirpath}" ] ; then

  mkdir config

fi

# CREATE BASHRC

bash_dirpath="${config_dirpath}/bash"

if ! [ -d "${bash_dirpath}" ] ; then

  mkdir ./config/bash

cat > "${bash_dirpath}/.bashrc" <<- EOM
#Container Color Scheme
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
PS1='\[\e[92m\]\u@\[\e[94m\]\h\[\e[0m\]:\[\e[36m\]\w\[\e[0m\]\n\$ ' 
EOM

fi

# DOWNLOAD NVIM CONFIG

nvim_config_dirpath="${config_dirpath}/neovim"

if ! [ -d ${nvim_config_dirpath} ] ; then

  mkdir -p ${nvim_config_dirpath}

  git clone -n --depth=1 --filter=tree:0 \
    https://github.com/RASC186/nvim-setup.git "${nvim_config_dirpath}" 

  git -C "${nvim_config_dirpath}" sparse-checkout set --no-cone nvim

  git -C "${nvim_config_dirpath}" checkout 

else

  git -C "${nvim_config_dirpath}" pull 

fi

# DOWNLOAD TMUX CONFIG

tmux_config_dirpath="${config_dirpath}/tmux/tmux"

if ! [ -d ${tmux_config_dirpath} ] ; then

  mkdir -p "${tmux_config_dirpath}" 

fi

curl -L https://raw.githubusercontent.com/RASC186/tmux-setup/main/tmux.conf \
  > "${tmux_config_dirpath}"/tmux.conf

# BUILD DOCKER CONTAINER

sudo docker build --tag dev-container ./
