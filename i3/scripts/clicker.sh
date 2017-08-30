#!/bin/zsh

case $BLOCK_BUTTON in
  1) cmus-remote -u
esac

state=`cmus-remote -Q | grep '^status' | awk '{gsub("status ", "");print}'`

if [ "$state" = "playing" ]; then
  echo "⏸"
else
  echo "▶"
fi
