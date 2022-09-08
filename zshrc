export ZSH="$HOME/.oh-my-zsh"
export LIBCLANG_PATH="$HOME/.espressif/tools/xtensa-esp32-elf-clang/esp-14.0.0-20220415-x86_64-unknown-linux-gnu/lib/"
export TERM="xterm-256color"
ZSH_THEME="himbeer" # set by `omz`
plugins=(git)
source $ZSH/oh-my-zsh.sh
source ~/.zsh_aliases

# fzf
source ~/.zsh_fzf_key_bindings
source ~/.zsh_fzf_completion

# SSH agent
export SSH_AUTH_SOCK="/tmp/ssh-${UID}/agent.sock"

function start_ssh_agent {
	mkdir -p /tmp/ssh-${UID}
	eval "$(ssh-agent -s -a /tmp/ssh-${UID}/agent.sock)"
}

pgrep -x ssh-agent > /dev/null || start_ssh_agent

# Start X?
if [[ "${TTY}" == "/dev/tty1" ]]; then
	startx
	exit 0
fi
