APPLY=true
CLEAN=false
for arg in "$@"; do
  case "$arg" in
    --clean)
      CLEAN=true
      APPLY=false
      ;;
  esac
done

if [ "$CLEAN" = true ]; then
  nix-collect-garbage -d
fi

if [ "$APPLY" = true ]; then
  home-manager switch --flake .#lain
fi
