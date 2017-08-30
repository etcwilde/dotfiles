git_url=`git config --get remote.origin.url`
git_domain=`echo $git_url | awk -v FS="(@|:)" '{print $2}'`
git_branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null`

if [[ $git_url == https://* ]]; then
  url=${git_url%.git}
elif [[ $git_url == git@* ]]; then
  cut=${git_url#*:}
  url=https://${git_domain}/${cut%.git}
else
  echo "Error, remote origin is invalid"
  exit 1
fi; xdg-open $url
