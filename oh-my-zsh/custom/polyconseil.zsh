plugins=(kubectl $plugins)

# git-repo and others
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

# Shitty 26 VPN
alias reupvpn="sudo ipsec restart; sleep 1; sudo ipsec up bluevpn"

# Postgresql
export PGUSER=postgres
export PGHOST=localhost
export PGPORT=5432
docker start postgres-local > /dev/null
