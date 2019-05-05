#!/bin/bash
# Jul 03, 2017
# Evan Wilde
# Time-based background selection

HR=$(echo `date +'%H'` | sed 's/^0*//')
if [[ $HR -gt 5 && $HR -lt 12 ]]; then
  # 5:00 AM - 12:00 AM (morning)
  BASE=~/.dotfiles/wallpapers/morning
elif [[ $HR -ge 12 && $HR -lt 18 ]]; then
  # 12:00 AM - 6:00 PM (Afternoon)
  BASE=~/.dotfiles/wallpapers/afternoon
else
  # 6:00 PM - 5:00 AM
  BASE=~/.dotfiles/wallpapers/night
fi

FILES=''
for F in `ls -U "$BASE"`; do
  FILES+="$BASE/$F "
done

/usr/bin/feh --randomize --bg-fill $FILES
