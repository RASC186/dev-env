#!/usr/bin/env bash

sudo docker run --privileged --net=host -e DISPLAY=$DISPLAY \
  -v "$(pwd)/workspace:/root/workspace" \
  -v tmux_data:/root/.config/tmux/plugins/ \
  -v nvim_data:/root/.local/share/nvim/ \
  -v /tmp/.X11-unix/:/tmp/.X11-unix/:ro \
  -it dev-container /bin/bash
