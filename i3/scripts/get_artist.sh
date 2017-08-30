cmus-remote -Q | grep "^tag artist" | awk '{gsub("tag artist ", "");print}'
