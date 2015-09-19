#!/bin/bash

# printf "$1"
query="$1"
dict=`cat`

i=0

first=`printf "$dict\n" | awk '{print $1}'`
# printf $first
one_word=`cat compressed/one_word_dictionary`
indexes=($first)

len=${#indexes[@]}
query=`echo $query |grep -oEi "([0-9]+\.[0-9]+)|([a-zA-Z]+)|([0-9]+)|([a-zA-Z0-9_\.\+]+\@[a-zA-Z0-9_]+\.[a-zA-Z]+)|(((http|https|file|ftp)://)?([a-zA-Z0-9][a-zA-Z0-9_\-]*\.)+[a-zA-Z]{2,7})" | awk -f stemmer.awk`
# echo $query
query_words=($query)

ret=""
mean=""
allfound=1
for j in $query
do
    found=0
    for i in `seq 0 $((len-2))`
    do
        cur=${indexes[i]}
        next=${indexes[$((i+1))]}
        dist=$((next-cur))
        word=${one_word:cur:dist}
        if test "$j" = "$word"
        then
            if test -n "$ret"
            then
                ret+="\n"
            fi
            ret+="$word "
            ret+=`printf "$dict\n"  | grep -i "^$cur" | awk '{$1=""; print $0} '`
            found=1
            break
        fi
    done

    if test $found -eq 0
    then
        allfound=0
        for i in `seq 0 $((len-2))`
        do
            cur=${indexes[i]}
            next=${indexes[$((i+1))]}
            dist=$((next-cur))
            word_list[$i]=${one_word:cur:dist}
                   
        done
        # printf "%s\n" "${word_list[@]}"
        pish=`printf "%s\n" "${word_list[@]}" | dist.py "$j"` 
        mean+="$pish "

    else
        mean+="$j "
    fi
done

if test $allfound -eq 1
then
    printf "$ret\n"
else
    echo "! $mean"
fi

