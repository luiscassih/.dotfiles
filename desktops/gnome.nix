{ config, pkgs, ... }:
let
in {
  home.packages = with pkgs; [
    gnome-tweaks
  ] ++ (with gnomeExtensions; [
    tweaks-in-system-menu
    caffeine
    astra-monitor
    auto-activities
    dash-to-dock
    places-status-indicator
    tactile
    kimpanel
    # useless-gaps
    (callPackage ./extra/gnome-extensions/useless-gaps.nix {})
    focus-changer
  ]);

  dconf.settings = {
    "org/gnome/shell" = {
      disabled-extensions = [];
      enabled-extensions = [
        "monitor@astraext.github.io"
        "caffeine@patapon.info"
        "dash-to-dock@micxgx.gmail.com"
        "focus-changer@heartmire"
        "places-menu@gnome-shell-extensions.gcampax.github.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
        "status-icons@gnome-shell-extensions.gcampax.github.com"
        "tweaks-in-system-menu@extensions.gnome-shell.fifi.org"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "tactile@lundal.io"
        "useless-gaps@pimsnel.com"
      ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];
      toggle-maximized=["<Super>m"];
      toggle-application-view=["<Super>v"];
      minimize = ["<Super>comma"];
      # cycle-windows=["<Super>j"];
      # cycle-windows-backward=["<Shift><Super>j"];
      move-to-workspace-1=["<Shift><Super>1"];
      move-to-workspace-2=["<Shift><Super>2"];
      move-to-workspace-3=["<Shift><Super>3"];
      move-to-workspace-4=["<Shift><Super>4"];
      # move-to-workspace-left=["<Shift><Super>h"];
      # move-to-workspace-right=["<Shift><Super>l"];
      switch-to-workspace-1=["<Super>1"];
      switch-to-workspace-2=["<Super>2"];
      switch-to-workspace-3=["<Super>3"];
      switch-to-workspace-4=["<Super>4"];
      # switch-input-source=["<Super>k"];
      # switch-input-source-backward=["<Shift><Super>k"];
      switch-windows=["<Super>Tab"];
      switch-windows-backward=["<Shift><Super>Tab"];
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      hot-keys = false;
    };
    "org/gnome/shell/extensions/useless-gaps" = {
      gap-size=15;
      no-gap-when-maximized=false;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings=["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
      home=["<Super>t"];
      magnifier=["<Super>z"];
      screensaver=[""];
    };
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left=["<Shift><Super>h"];
      toggle-tiled-right=["<Shift><Super>l"];
      toggle-tiled-top=["<Shift><Super>k"];
      toggle-tiled-bottom=["<Shift><Super>j"];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding="<Super>Return";
      command="kitty";
      name="Kitty";
    };
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui=["<Shift><Super>s"];
      toggle-application-view=["<Super>v"];
      toggle-message-tray=[""];
      switch-to-application-1=[""];
      switch-to-application-2=[""];
      switch-to-application-3=[""];
      switch-to-application-4=[""];
    };
    "org/gnome/shell/extensions/tactile" = {
      col-1=1;
      col-2=0;
      col-3=0;
      grid-cols=2;
      grid-rows=2;
      show-tiles=["<Super>a"];
      tile-1-0=["e"];
      tile-1-1=["d"];
    };
    # "org/gnome/desktop/input-sources" = {
    #   mru-sources=["('xkb', 'us'), ('ibus', 'anthy')"];
    #   sources=["('xkb', 'us'), ('ibus', 'anthy')"];
    # };
    "org/freedesktop/ibus/engine/anthy/common" = {
      input-mode=0;
    };
  };
}
