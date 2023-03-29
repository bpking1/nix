let
  common = import ../common;
in
[
  ./imgview  # good, imv ./*.jpg
  ./launcher
  ./notice
  ./mpv
  ./kooha
] ++ common
