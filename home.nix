{ config, pkgs, lib, ... }:
let
  configPath = "/home/l/.dotfiles";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "l";
  home.homeDirectory = "/home/l";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  imports = [
    # ./desktops/hyprland.nix
    ./desktops/kde.nix
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    starship
    neovim

    git lazygit
    dua

    vesktop
    telegram-desktop

    firefox google-chrome
    kitty tmux
    fzf bat ripgrep fd jq lf
    zsh-fzf-tab
    tree less
    p7zip zip unzip
    luajitPackages.luarocks
    yt-dlp
    aseprite
    audacity
    spotify
    cowsay
    qbittorrent

    #dev
    tldr
    pnpm bun
    rustup
    python3
    gcc clang gnumake
    imagemagick

    # Fonts
    nerd-fonts.monofur
    roboto
    hack-font
    liberation_ttf
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    source-han-sans
    source-han-serif
    ubuntu-sans
  ];

  fonts.fontconfig.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    # ".config/nvim".source = symlink configPath + /dotfiles/.config/nvim;
    ".zshrc".source = symlink configPath + /dotfiles/.zshrc;
    ".config/lf".source = ./dotfiles/lf;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/l/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    HSA_OVERRIDE_GFX_VERSION="10.3.0";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        v = "nvim";
        t = "tmux";
        so = "source ~/.zshrc";
        tmuxsource = "tmux source ~/.config/tmux/tmux.conf";
        ta = "tmux a -t";
        conf = "ts ~/.config/nvim";
        # xsc="pbcopy" #mac
        # xsc="xclip -selection clipboard" #linux
        # xsc = "wl-copy" #wayland
        resetsshagent = "killall ssh-agent; eval `ssh-agent`";
        resetwaybar = "killall waybar; hyprctl dispatch exec waybar &";
        data = "cd /mnt/DATA";
        s = ''rg --files --hidden --glob "!.git" | fzf'';
        sd = ''cd $(s | xargs dirname)'';
        sv = ''nvim $(s)'';
        sudoenv = "sudo -E env PATH=$PATH";
        retab = ''nvim -s <(echo -e "gg=G\n:retab\nZZ")'';
        ":q" = "exit";
        man = "tldr";
      };
      initExtra = ''
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        source ~/.config/lf/icons
        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

        how() {
          if [ -z "$1" ]; then
            echo "No search term provided."
            return 1
          fi
          query=$(printf '%q ' "$@")
          sgpt --shell "$query"
        }

        tnew() {
          if [ -z "$1" ]; then
            echo "No session name provided."
            return 1
          fi

          # Check if tmux session exists
          if tmux has-session -t $1 2>/dev/null; then
            echo "Session $1 already exists."
          else
            tmux new-session -s $1
          fi
        }

        vs() {
          if [ -f ".vimsession" ]; then
            nvim -S .vimsession
          else
            nvim .
          fi
        }

        lt() {
          tree -I "node_modules" "$@" -C | less -r
        }

        lfcd () {
            tmp="$(mktemp)"
            lf -last-dir-path="$tmp" "$@"
            if [ -f "$tmp" ]; then
                dir="$(cat "$tmp")"
                rm -f "$tmp"
                if [ -d "$dir" ]; then
                    if [ "$dir" != "$(pwd)" ]; then
                        cd "$dir"
                    fi
                fi
            fi
        }
      '';
    };
    starship.enable = true;
    git = {
      enable = true;
      userName = "luisc";
      userEmail = "luiscassih@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
  programs.bash.profileExtra = lib.mkAfter ''
    rm -rf ${config.home.homeDirectory}/.local/share/applications/home-manager
    rm -rf ${config.home.homeDirectory}/.icons/nix-icons
    ls ${config.home.homeDirectory}/.nix-profile/share/applications/*.desktop > ${config.home.homeDirectory}/.cache/current_desktop_files.txt
  '';
  home.activation = {
    linkDesktopApplications = {
      after = ["writeBoundary" "createXdgUserDirectories"];
      before = [];
      data = ''
        rm -rf ${config.home.homeDirectory}/.local/share/applications/home-manager
        rm -rf ${config.home.homeDirectory}/.icons/nix-icons
        mkdir -p ${config.home.homeDirectory}/.local/share/applications/home-manager
        mkdir -p ${config.home.homeDirectory}/.icons
        ln -sf ${config.home.homeDirectory}/.nix-profile/share/icons ${config.home.homeDirectory}/.icons/nix-icons

        # Check if the cached desktop files list exists
        if [ -f ${config.home.homeDirectory}/.cache/current_desktop_files.txt ]; then
          current_files=$(cat ${config.home.homeDirectory}/.cache/current_desktop_files.txt)
        else
          current_files=""
        fi

        # Symlink new desktop entries
        for desktop_file in ${config.home.homeDirectory}/.nix-profile/share/applications/*.desktop; do
          if ! echo "$current_files" | grep -q "$(basename $desktop_file)"; then
            ln -sf "$desktop_file" ${config.home.homeDirectory}/.local/share/applications/home-manager/$(basename $desktop_file)
          fi
        done

        # Update desktop database
        ${pkgs.desktop-file-utils}/bin/update-desktop-database ${config.home.homeDirectory}/.local/share/applications
      '';
    };
  };
}
