#!/bin/bash

hadoop jar /usr/lib/hadoop-2.5.1/share/hadoop/tools/lib/hadoop-streaming-2.5.1.jar \
        -D mapred.output.key.comparator.class=org.apache.hadoop.mapred.lib.KeyFieldBasedComparator \
        -D mapred.text.key.comparator.options='-k 1,1 -k 2n' \
        -D stream.num.map.output.key.fields=2  \
        -input proj2 \
        -output proj_out \
        -mapper ./mapper.sh \
        -reducer ./reducer.sh 
