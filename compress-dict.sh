#!/bin/bash


rm -rf part-00000 dictionary_compressed number_index one_word_dictionary
hadoop fs -get proj_out2/part-00000
words=`cat part-00000 | awk '{print $1}'`
allwords=`printf "%s," $words`

len=0
for i in $words
do
    echo $len
    str_len=${#i}
    len=$((len+str_len))
done >> number_index


# chr `cat numbers_index` > number_index
# awk '
#     NR==FNR {
#         while ($0!="") {
#             a[++i] = substr($0,1,2)
#             # printf "%x", substr($0,1,2)
#             $0 = substr($0,3)
            
#         }
#         next
#     }
#     { $1 = a[FNR] }1 ' \
#     RS='^$' number_index RS='\n' ORS="" part-00000 > dictionary_compressed

awk 'FNR==NR{a[NR]=$0;next} { $1=a[FNR] }1' number_index part-00000 > dictionary_compressed
echo $allwords | sed "s/,//g" > one_word_dictionary #remove parts



hadoop fs -rm -r -f compressed
hadoop fs -mkdir compressed
hadoop fs -put one_word_dictionary compressed
hadoop fs -put number_index compressed
hadoop fs -put dictionary_compressed compressed
hadoop fs -cp doc_freqs/part-00000 compressed/doc_freqs
rm -rf one_word_dictionary number_index dictionary_compressed #cleaning

du -b compressed/dictionary_compressed
du -b part-00000

#echo "compression percent: $(())"
