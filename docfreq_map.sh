#!/bin/bash

while read line
do
    echo $line | grep -oEi "(\([0-9]+ [0-9]+\))" | cut -d "(" -f2 | cut -d ")" -f1
done