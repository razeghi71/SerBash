#!/bin/bash


function stemize
{
    echo "$1" |grep -oEi "([0-9]+\.[0-9]+)|([a-zA-Z]+)|([0-9]+)|([a-zA-Z0-9_\.\+]+\@[a-zA-Z0-9_]+\.[a-zA-Z]+)|(((http|https|file|ftp)://)?([a-zA-Z0-9][a-zA-Z0-9_\-]*\.)+[a-zA-Z]{2,7})"| paste -sd' ' | awk -f stemmer.awk
}


function and_search
{
    rm -rf and_search
    stemed=`stemize "$1"`
    hadoop jar /usr/lib/hadoop-2.5.1/share/hadoop/tools/lib/hadoop-streaming-2.5.1.jar \
        -input compressed/dictionary_compressed \
        -output and_search \
        -mapper "./search_map.sh '$1'" \
        -reducer "./and_reduce.py '$stemed'" 2>/dev/null
}


function nr_search
{
    rm -rf nr_search
    stemed=`stemize "$1"`
    hadoop jar /usr/lib/hadoop-2.5.1/share/hadoop/tools/lib/hadoop-streaming-2.5.1.jar \
        -input compressed/dictionary_compressed \
        -output nr_search \
        -mapper "./search_map.sh '$1'" \
        -reducer "./nr_reduce.py '$stemed'" 2>/dev/null
}


function ltn_search
{
    rm -rf ltn_search
    stemed=`stemize "$1"`
    hadoop jar /usr/lib/hadoop-2.5.1/share/hadoop/tools/lib/hadoop-streaming-2.5.1.jar \
        -input compressed/dictionary_compressed \
        -output ltn_search \
        -mapper "./search_map.sh '$1'" \
        -reducer "./ltn-lnn.py '$stemed'" 2>/dev/null
}

function ltc_search
{
    rm -rf ltc_search
    stemed=`stemize "$1"`
    hadoop jar /usr/lib/hadoop-2.5.1/share/hadoop/tools/lib/hadoop-streaming-2.5.1.jar \
        -input compressed/dictionary_compressed \
        -output ltc_search \
        -mapper "./search_map.sh '$1'" \
        -reducer "./ltc-lnc.py '$stemed'" 2>/dev/null
}

# ltc_search "0 hi"
