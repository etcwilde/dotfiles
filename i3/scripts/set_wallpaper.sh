#!/bin/bash
# Jul 03, 2017
# Evan Wilde
# Time-based background selection

HR=$(echo `date +'%H'` | sed 's/^0*//')
if [[ $HR -gt 5 && $HR -lt 11 ]]; then
  # 5:00 AM - 11:00 AM (morning)
  echo 'Morning'
  BASE=~/.dotfiles/wallpapers/morning
elif [[ $HR -ge 11 && $HR -lt 18 ]]; then
  # 11:00 AM - 6:00 PM (Afternoon)
  echo 'Afternoon'
  BASE=~/.dotfiles/wallpapers/afternoon
else
  # 6:00 PM - 5:00 AM
  echo 'Night'
  BASE=~/.dotfiles/wallpapers/night
fi

FILES=''
for F in `ls -U "$BASE"`; do
  FILES+="$BASE/$F "
done

/usr/bin/feh --randomize --bg-fill $FILES
