#!/bin/bash

hadoop fs -rm -r -f proj_out3

hadoop jar /usr/lib/hadoop-2.5.1/share/hadoop/tools/lib/hadoop-streaming-2.5.1.jar \
        -D mapred.output.key.comparator.class=org.apache.hadoop.mapred.lib.KeyFieldBasedComparator \
        -D mapred.text.key.comparator.options='-k 1,1 -k 2n' \
        -D stream.num.map.output.key.fields=2  \
        -input proj_out2 \
        -output proj_out3 \
        -mapper ./mapperi.sh \
        -reducer ./reduceri.sh 

hadoop fs -rm -r -f proj_out proj_out2
hadoop fs -mv proj_out3 proj_out

./map_reducef.sh