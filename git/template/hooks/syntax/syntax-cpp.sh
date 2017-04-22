#!/bin/sh
# Evan Wilde      <etcwilde@uvic.ca>
# 2017

git diff --cached --name-only --relative -- '*.cpp' '*.c++' '*.C' | while read FILE; do
if [[ "$FILE" =~ ^.+(cpp|c++|C)$ ]]; then
  if [[ -f $FILE ]]; then
    g++ --std=c++11 -fsyntax-only "$FILE" 2> /dev/null
    if [ $? -ne 0 ]; then
      echo -e "\e[1;31mError:\e[0m Aborting commit: Syntax Error in File: "$FILE >&2
      exit 1
    fi
  fi
fi
done || exit $?
