#!/usr/bin/env bash

sudo docker run --privileged --net=host \
  -v workspace:/root/workspace \
  -v tmux_data:/root/.config/tmux/plugins/ \
  -v nvim_data:/root/.local/share/nvim/ \
  -it dev-container /bin/bash
