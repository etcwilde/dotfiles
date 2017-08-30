#!/bin/bash
title=`cmus-remote -Q | grep "^tag title" | awk '{gsub("tag title ", "");print}'`
artist=`cmus-remote -Q | grep "^tag artist" | awk '{gsub("tag artist ", "");print}'`
state=`cmus-remote -Q | grep "^status" | awk '{gsub("status ", ""); print}'`

msg=""

case $state in
  stopped)
    msg=""
    ;;
  paused )
    msg="$msg [$title -- $artist]"
    ;;
  playing )
    msg="$msg $title -- $artist"
    ;;
  *)
    ;;
esac


case $BLOCK_BUTTON in
  1)
    cmus-remote -u
    ;;
  4)
    cmus-remote -r
    ;;
  5)
    cmus-remote -n
    ;;
  *)
    ;;
esac
echo $msg
