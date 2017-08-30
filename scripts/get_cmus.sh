#!/bin/sh

if  ps -C cmus > /dev/null; then
  title=`cmus-remote -Q | grep --text '^tag title' | awk '{gsub("tag title ", "");print}'`
  artist=`cmus-remote -Q | grep --text '^tag artist' | awk '{gsub("tag artist ", "");print}'`
  echo "Playing: $title -- $artist";
else
  echo ""
fi

