#!/usr/bin/env sh

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <file> <line>"
  exit 1
fi

CWD=$PWD
if [[ ! -z GIT_PREFIX ]]; then
  CWD=$PWD/$GIT_PREFIX
fi

FILE=$1
LINE=$2

git log -u -L $LINE,$LINE:$CWD/$FILE --format='%h (%aN %ai) %s'

# vim:set et sw=2 ts=2 sts=2 tw=72:
