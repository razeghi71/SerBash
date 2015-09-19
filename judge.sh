#!/bin/bash

cat RelevancyJudgments/relevance | cut -d " " -f 2- > rel_judge


for i in `seq 1 $2`
do
    sed "$i!d" rel_judge > testfile
    cat evals1/evals_1_"$i" >> testfile
    ./evaluation_res.py < testfile
done > nr_eval

for i in `seq 1 $2`
do
    sed "$i!d" rel_judge > testfile
    cat evals2/evals_2_"$i" >> testfile
    # cat testfile
    ./evaluation_res.py < testfile
done > and_eval

for i in `seq 1 $2`
do
    sed "$i!d" rel_judge > testfile
    cat evals3/evals_3_"$i" >> testfile
    # cat testfile
    ./evaluation_res.py < testfile
done > ltn_lnn_eval

for i in `seq 1 $2`
do
    sed "$i!d" rel_judge > testfile
    cat evals4/evals_4_"$i" >> testfile
    # cat testfile
    ./evaluation_res.py < testfile
done > ltc_lnc_eval