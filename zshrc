export ZSH="$HOME/.oh-my-zsh"
export LIBCLANG_PATH="$HOME/.espressif/tools/xtensa-esp32-elf-clang/esp-14.0.0-20220415-x86_64-unknown-linux-gnu/lib/"
export PATH="$HOME/.espressif/tools/xtensa-esp32-elf-gcc/8_4_0-esp-2021r2-patch3-x86_64-unknown-linux-gnu/bin/:$HOME/go/bin:$HOME/bin:/usr/local/go/bin:$PATH"
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
