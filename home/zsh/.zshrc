# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="sunrise"

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/lib/colorgcc/bin

eval `dircolors ~/.dir_colors/gruvbox-dark`

# Path for fzf plugin to find fzf binary
export FZF_BASE=/usr/share/fzf
export FZF_CTRL_R_OPTS='--reverse'

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(django kubectl fancy-ctrl-z fzf git git-flow poetry virtualenvwrapper)

source $ZSH/oh-my-zsh.sh

# Initialize autocompletion with extra functions (man zshbuiltins for options)
autoload -Uz compinit && compinit
autoload -U bashcompinit && bashcompinit

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

# Enable emacs command line edition
bindkey -e  # vim doesn't handle ctrl-z properly

# pyenv (oh-my-zsh plugin doesn't seem to load virtualenv correctly)
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
# virtualenvwrapper uses pyenv virtualenv
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
pyenv virtualenvwrapper_lazy

# poetry
export PATH=$HOME/.poetry/bin:$PATH

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


# local config
if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
