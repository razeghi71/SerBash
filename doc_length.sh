#!/bin/bash

cat compressed/doc_freqs  | grep "^$1\s" | awk '{print $2}'
