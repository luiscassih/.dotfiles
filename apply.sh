APPLY=true
CLEAN=false
INSTALL=false
for arg in "$@"; do
  case "$arg" in
    --clean)
      CLEAN=true
      APPLY=false
      ;;
    --install)
      INSTALL=true
      APPLY=false
      ;;
  esac
done

if [ "$CLEAN" = true ]; then
  nix-collect-garbage -d
fi

if [ "$INSTALL" = true ]; then
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager 
  nix-channel --update
  nix-shell '<home-manager>' -A install
  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  else
    echo "TPM is already installed"
  fi
fi

if [ "$APPLY" = true ]; then
  home-manager switch --flake .#lain
fi
