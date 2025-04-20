{ config, pkgs, ... }:
let
in {
  home.packages = with pkgs; [
    wofi
    wf-recorder
  ];
}
