#!/usr/bin/env bash

# Copyright (c) 2021-2025 Your Name
# Author: Your Name
# License: MIT
# Source: https://octoeverywhere.com/

source /dev/stdin <<<"$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apt-get install -y \
    git \
    curl
msg_ok "Installed Dependencies"

msg_info "Setting Up Python Environment"
$STD apt-get install -y \
    python3 \
    python3-pip \
    python3-venv
msg_ok "Python Environment Set Up"

msg_info "Cloning OctoEverywhere Repository"
cd ~
if [ -d "./octoeverywhere" ]; then
    msg_info "OctoEverywhere repo already exists, pulling latest changes."
    cd octoeverywhere
    $STD git pull
else
    $STD git clone https://github.com/QuinnDamerell/OctoPrint-OctoEverywhere.git octoeverywhere
    cd octoeverywhere
fi
msg_ok "OctoEverywhere Repository Cloned"

msg_info "Installing OctoEverywhere for Elegoo"
$STD sudo date -s $(curl --insecure 'https://octoeverywhere.com/api/util/date' 2>/dev/null)
$STD git reset --hard --quiet
$STD git checkout master --quiet
$STD ./install.sh -elegoo
msg_ok "OctoEverywhere for Elegoo Installed"

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
