{ config, pkgs, ... }:
{
  programs.vscode =
    let
      package = pkgs.vscode.fhs;
    in
    {
      inherit package;
      enable = true;
    };
}
