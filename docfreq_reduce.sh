#!/bin/bash

read curdoc curfreq
while read doc freq; do
  if [[ "$doc" = "$curdoc" ]]; then
    curfreq=$(( curfreq + freq ))
  else
    printf "%s\t%s\n" "$curdoc" "$curfreq"
    curdoc="$doc"
    curfreq="$freq"
  fi
done
printf "%s\t%s\n" "$curdoc" "$curfreq"
