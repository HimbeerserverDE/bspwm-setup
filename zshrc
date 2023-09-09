# SSH agent
export SSH_AUTH_SOCK="/tmp/ssh-${UID}/agent.sock"

function start_ssh_agent {
	mkdir -p /tmp/ssh-${UID}
	eval "$(ssh-agent -s -a /tmp/ssh-${UID}/agent.sock)"
}

pgrep -x ssh-agent > /dev/null || start_ssh_agent

# Start WM?
if [[ "${TTY}" == "/dev/tty1" ]]; then
	river
	exit 0
fi

# Else: Actual ZSH RC
export ZSH="$HOME/.oh-my-zsh"

export LIBCLANG_PATH="/usr/lib"
export PATH="$HOME/go/bin:$HOME/bin:/usr/local/go/bin:$PATH"

export EDITOR="vim"

ZSH_THEME="himbeer" # set by `omz`
plugins=(git)
source $ZSH/oh-my-zsh.sh

source ~/.zsh_aliases

# fzf
source ~/.zsh_fzf_key_bindings
source ~/.zsh_fzf_completion
