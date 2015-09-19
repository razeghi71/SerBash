#!/bin/bash

stopwordlist=`cat stopwords`
filenum=`echo $mapreduce_map_input_file | awk -F/ '{print $NF}' | grep -oEi [0-9]+`

while read split
do
    split=`echo $split |grep -oEi "([0-9]+\.[0-9]+)|([a-zA-Z]+)|([0-9]+)|([a-zA-Z0-9_\.\+]+\@[a-zA-Z0-9_]+\.[a-zA-Z]+)|(((http|https|file|ftp)://)?([a-zA-Z0-9][a-zA-Z0-9_\-]*\.)+[a-zA-Z]{2,7})" | awk -f stemmer.awk`
    for word in $split
    do
        $(echo -e "$stopwordlist" | grep -i "^$word$"  > /dev/null)  && continue
        if test -n "$word"
        then
            printf "%s\t%s\t%s\n" "$word" "$filenum" "1"
        fi
    done
done
