################### History ###################
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt appendhistory          # Multiple sessions writes to same file instead of overwriting
setopt hist_ignore_all_dups   # Ignore duplicate entries in history

################### Navigation ###################
setopt autocd   # cd just by typing directory name

################### Environment ###################
# Make vim the default editor
export EDITOR=vim
# Make vim git's commit editor
export GIT_EDITOR='vim'
# Configure virtualenvwrapper folder
export WORKON_HOME=~/.virtualenvs/
