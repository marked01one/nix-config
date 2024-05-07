{pkgs}:
pkgs.writeShellScriptBin "swww-init" ''
  numOfWallpapers=$(ls -lR $HOME/Pictures/Wallpapers | grep '^l' | wc -l)
  randNum=$((1 + $RANDOM % $numOfWallpapers))
  swww-daemon &
  swww img ~/Pictures/Wallpapers/$randNum.* --transition-step=15 --transition-fps=240 --transition-type=wipe --transition-angle=0 --transition-duration=1 &
  nm-applet --indicator &
  waybar &
''
