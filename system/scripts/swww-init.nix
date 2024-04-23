{pkgs}:
pkgs.writeShellScriptBin "swww-init" ''
  numOfWallpapers=$(ls -lR $HOME/Pictures/Wallpapers | grep '^l' | wc -l)
  randNum=$((1 + $RANDOM % $numOfWallpapers))
  swww-daemon &
  swww img ~/Pictures/Wallpapers/$randNum.* &
  nm-applet --indicator
''
