#!/bin/bash

ssh() {
	cat <<- _EOF_ >> ~/.ssh/config
		Host aur-dev
		    User aur
		    Hostname aur-dev.archlinux.org
		    IdentityFile ~/.ssh/keys/aur-dev
		    Port 2222
_EOF_
}

modules() {
    echo "Setting up sub-repos..."
    git submodule init && git submodule update --remote
}

hooks() {
    echo "Adding commit hooks..."
    shopt -s nullglob
    for folder in .git/modules/*/hooks/ */.git/hooks/; do
        ln -sf ../../../../pre-commit.hook ${folder}/pre-commit
        ln -sf ../../../../post-commit.hook ${folder}/post-commit
    done
}

all() {
    ssh
    modules
    hooks
}

${1}
