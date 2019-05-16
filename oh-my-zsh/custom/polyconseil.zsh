plugins=(kubectl $plugins)

# 'load_dump' function
source $HOME/.zsh_functions/pg_restore_dump.sh

# git-repo
export PATH="$PATH:$HOME/bin"

# Required to build polysonar
export CROSS_COMPILE="arm-none-eabi"
export LINUX_CROSS_COMPILE="arm-linux-gnueabihf"

# Avoid specifying "--connect qemu:///system" with virsh calls
export LIBVIRT_DEFAULT_URI="qemu:///system"

# Node stuff
# ==========
# Enable nvm (Node Version Manager, nvm on the AUR)
function nvminit
{
    source /usr/share/nvm/init-nvm.sh;
}
