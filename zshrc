# SSH agent
export SSH_AUTH_SOCK="/tmp/ssh-${UID}/agent.sock"

function start_ssh_agent {
	mkdir -p /tmp/ssh-${UID}
	eval "$(ssh-agent -s -a /tmp/ssh-${UID}/agent.sock)"
}

pgrep -x ssh-agent > /dev/null || start_ssh_agent

# Start WM?
if [[ "${TTY}" == "/dev/tty1" ]]; then
	export XDG_CURRENT_DESKTOP=river

	dbus-run-session river
	exit 0
fi

# Else: Actual ZSH RC
export HISTFILE="${HOME}/.zsh_history"

export LIBCLANG_PATH="/usr/lib"
export PATH="$HOME/.cargo/bin:$HOME/go/bin:$HOME/bin:/usr/local/go/bin:$PATH"

export EDITOR="vim"

fpath=("${HOME}/.zprompts" "${fpath[@]}")

autoload -Uz compinit
compinit

autoload -U colors
colors

autoload -Uz promptinit
promptinit

setopt autocd

# vi mode for line editing
bindkey -v

find ~/.zplugins -maxdepth 1 -type "f,l" -name "*.zsh" | while read -r PLUGIN
do
	source ${PLUGIN}
done

prompt himbeer

source ~/.zsh_aliases

# fzf
source ~/.zsh_fzf_key_bindings
source ~/.zsh_fzf_completion
