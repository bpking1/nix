{ config, pkgs, ... }:
let
in
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
