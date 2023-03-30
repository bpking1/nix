{ config, lib, pkgs, inputs, ... }:
{
  imports = [ ../../programs/wayland/waybar/hyprland_waybar.nix ];

  programs = {
    dconf.enable = true;
    light.enable = true;
  };

  environment.systemPackages = with pkgs; [
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    swww
    swaylock-effects
    pamixer
  ];

  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # flatpak need this
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
  };
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-wlr
  #     xdg-desktop-portal-kde
  #     xdg-desktop-portal-gtk
  #   ];
  #   wlr = {
  #     enable = true;
  #     settings = { # uninteresting for this problem, for completeness only
  #       screencast = {
  #         output_name = "eDP-1";
  #         max_fps = 30;
  #         chooser_type = "simple";
  #         chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
  #       };
  #     };
  #   };
  # };

}
