#!/bin/bash

stopwordlist=`cat stopwords`

if [[ $mapreduce_map_input_file =~ .*part.* ]]
then 
    while read split
    do
        a=(echo $split)
        b=${#a[@]}
        for i in `seq 2 2 $(($b-2))`
        do
            printf "%s\t%s\t%s\n" ${a[1]} ${a[$i]:1} ${a[$((i+1))]:0:-1}
        done
    done
else
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
fi