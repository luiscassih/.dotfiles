source "$HOME/.cargo/env"

# export CHROME_EXECUTABLE="/var/lib/flatpak/app/com.google.Chrome/current/active/export/bin/com.google.Chrome"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/l/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/l/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/l/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/l/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:$(go env GOPATH)/bin"
export GOPATH=$(go env GOPATH)
# add mason
export PATH="$PATH:/home/l/.local/share/nvim/mason/bin:$PATH"

# java home
export JAVA_HOME="/home/l/jdk/jdk-17.0.10+7"

# pnpm
export PNPM_HOME="/home/l/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#
export ANDROID_HOME="/home/l/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export NDK_HOME="/home/l/Android/Sdk/ndk/27.0.11718014"
export ANDROID_NDK_ROOT="$NDK_HOME"

# bun completions
[ -s "/home/l/.bun/_bun" ] && source "/home/l/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/Apps/bin:$PATH"
export OLLAMA_API_BASE=http://127.0.0.1:11434

export PATH="$HOME/.local/bin:$PATH"

# Odin lang
export PATH="$HOME/.odin:$PATH"

export VULKAN_SDK="$HOME/VulkanSDK/1.3.296.0/x86_64/"
source /home/l/VulkanSDK/1.3.296.0/setup-env.sh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Temp for VirtualBox
# export LIBGL_ALWAYS_SOFTWARE=true
# export GALLIUM_DRIVER=llvmpipe
