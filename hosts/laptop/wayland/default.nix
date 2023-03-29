{ config, pkgs, user, inputs, ... }:

{
  imports =
    (import ../../../modules/hardware) ++
    (import ../../../modules/virtualisation) ++
    [
      ../hardware-configuration.nix
      ../../../modules/fonts
    ] ++ [
      # ../../../modules/desktop/sway
      ../../../modules/desktop/hyprland
    ];

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  users.mutableUsers = false;
  users.users.root.initialHashedPassword = "$6$aKHJUVkP0FVzg3iE$8mw7srDXY4FepxChTYzM6Ecf7d5nhrUgxTV9s81Wj2PAMangUl1ZkC1vxGRQJ7zQn2COTZnMVTTCgSQ7T1enP1";
  users.users.${user} = {
    initialHashedPassword = "$6$aKHJUVkP0FVzg3iE$8mw7srDXY4FepxChTYzM6Ecf7d5nhrUgxTV9s81Wj2PAMangUl1ZkC1vxGRQJ7zQn2COTZnMVTTCgSQ7T1enP1";
    # shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "video" "audio" ];
    packages = (with pkgs; [
      # qq # qq official client
      # aichat  # chat gpt
      tdesktop  # telegram
      dbeaver
    ]) ++ (with config.nur.repos;[
      linyinfeng.icalingua-plus-plus
    ]);
  };
  boot = {
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      timeout = 3;
    };
    kernelParams = [
      "quiet"
      "splash"
      "nvidia-drm.modeset=1"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    # rime 输入法，wiki，moe词库
    fcitx5.addons = with pkgs; [ fcitx5-rime fcitx5-chinese-addons fcitx5-table-extra fcitx5-pinyin-moegirl fcitx5-pinyin-zhwiki ];
  };

  environment = {
    persistence."/nix/persist" = {
      directories = [
        "/etc/nixos" # bind mounted from /nix/persist/etc/nixos to /etc/nixos
        "/etc/NetworkManager/system-connections"
        "/etc/v2raya"
        "/var/log"
        "/var/lib"
      ];
      users.${user} = {
        directories = [
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          ".cache"
          "Codelearning"
          ".npm-global"
          ".config"
          # ".thunderbird"
          ".go-musicfox"
          "Flakes"
          "Kvm"
          { directory = ".gnupg"; mode = "0700"; }
          { directory = ".ssh"; mode = "0700"; }
          ".local"
          ".mozilla"
        ];
        files = [
          ".npmrc"
        ];
      };
    };
    systemPackages = with pkgs; [
      libnotify
      wl-clipboard
      wlr-randr
      wayland
      wayland-scanner
      wayland-utils
      egl-wayland
      wayland-protocols
      pkgs.xorg.xeyes
      glfw-wayland
      xwayland
      pkgs.qt6.qtwayland
      cinnamon.nemo
      networkmanagerapplet
      wev
      wf-recorder # screen record
      alsa-lib
      alsa-utils
      flac
      pulsemixer
      linux-firmware
      sshpass
      pkgs.rust-bin.stable.latest.default
      lxappearance
      imagemagick
      pkgs.sway-contrib.grimshot # 截图
      flameshot # 截图 for xorg
      grim  # 截图 grimblast --cursor copy area
    ];
  };

  services.xserver = {
    xkbOptions = "caps:escape";
  };
  console.useXkbConfig = true;

  services = {
    dbus.packages = [ pkgs.gcr ];
    getty.autologinUser = "${user}";
    gvfs.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  security.polkit.enable = true;
  security.sudo = {
    enable = false;
    extraConfig = ''
      ${user} ALL=(ALL) NOPASSWD:ALL
    '';
  };
  security.doas = {
    enable = true;
    extraConfig = ''
      permit nopass :wheel
    '';
  };

}
