#!/bin/bash

read curterm curfile curtf curdf
buffer="$curterm\t"
while read term file tf df
do
    if test "$term" = "$curterm" 
    then
        curdf=$(( curdf + df ))
        buffer+="($file\t$tf)\t"
    else
        buffer+="\t$curdf"
        echo -e "$buffer"
        buffer="$term\t($file\t$tf)\t"
        curfile="$file"
        curterm="$term"
        curtf="$tf"
        curdf="$df"
    fi
done

buffer+="$curfile\t$curtf\t$curdf"