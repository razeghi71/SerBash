#!/bin/bash 

#calc doc freqs
rm -rf doc_freqs
hadoop jar /usr/lib/hadoop-2.5.1/share/hadoop/tools/lib/hadoop-streaming-2.5.1.jar \
        -D mapred.output.key.comparator.class=org.apache.hadoop.mapred.lib.KeyFieldBasedComparator \
        -D mapred.text.key.comparator.options='-k 1,1n' \
        -D stream.num.map.output.key.fields=1  \
        -input proj_out2 \
        -output doc_freqs \
        -mapper ./docfreq_map.sh \
        -reducer ./docfreq_reduce.sh