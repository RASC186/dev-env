#!/usr/bin/env bash

sudo docker run --privileged \
  -v workspace:/root/workspace \
  -v nvim_data:/root/.local/share/nvim/ \
  -it dev-container /bin/bash
