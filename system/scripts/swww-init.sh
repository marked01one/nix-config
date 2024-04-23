numOfWallpapers = $(find ~/Pictures/Wallpapers/ -maxdepth 1 -type f | wc -l)
randNum = $((1 + $RANDOM % $numOfWallpapers))
  
swww-deamon &
swww img ~/Pictures/Wallpapers/$randNum.* &
nm-applet --indicator
