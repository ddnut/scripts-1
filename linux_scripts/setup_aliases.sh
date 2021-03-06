#!/bin/bash

# Script to configure aliases
# Does not need to be executed as root.

# Get username
user_name=$(logname)

# Setup bashrc config
cat <<\EOF >> "/home/${user_name}/.bashrc"

# Aliases
alias sudo='sudo '
alias ssh_nas="ssh -i '/mnt/matt-nas/SSHConfigs/matt_homelab/nas.openssh' matthew@matt-nas.miller.lan"
alias ssh_openwrt="ssh -i '/mnt/matt-nas/SSHConfigs/matt_homelab/openwrt.openssh' matthew@mattopenwrt.miller.lan"
alias ssh_proxmox="ssh -i '/mnt/matt-nas/SSHConfigs/matt_homelab/proxmox.openssh' matthew@matt-prox.miller.lan"
alias ssh_vpn="ssh -i '/mnt/matt-nas/SSHConfigs/matt_homelab/vpn.openssh' matt-vpn@matt-vpn.miller.lan"
alias ssh_pihole="ssh -i '/mnt/matt-nas/SSHConfigs/matt_homelab/pihole.openssh' pihole@matt-pihole.miller.lan"
alias pacman_autoremove='pacman -Rs $(pacman -Qtdq)'

EOF
