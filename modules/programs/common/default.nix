{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      rofi-wayland  # launcher
      imv # image viewer
      #find 
      fd
      bat
      ripgrep
    ];
  };
  programs = {
    fzf.enable = true; # find
    # terminal
    kitty = {
      enable = true;
      environment = { };
      keybindings = { };
    };
    mako.enable = true; # notice
  };
}