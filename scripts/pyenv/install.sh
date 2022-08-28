#!/bin/sh
set -e

curl https://pyenv.run | bash
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper
