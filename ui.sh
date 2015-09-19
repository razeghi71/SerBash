#!/bin/bash

. and_search.sh

dialog --title "Welcome" --msgbox "please wait ... search engine loading" 5 45

while true
do

    dialog --menu "which type of search do you want?" 15 40 4    \
            1 "nr of accourance" \
            2 "and query" \
            3  "tf-idf -> lnn-ltn" \
            4 "tf-idf -> lnc-ltc" 2>out 

    choise=$(cat out)
    
    if [ "$choise" == "" ];then
        dialog --title "GoodBye" --msgbox "GoodBye Honey" 5 45
        exit;
    fi

    dialog --inputbox "input your query" 10 100 2>out
    query=$(cat out)

    if [ "$query" == "" ];then
        continue;
    fi

    while true
    do
        if test "$choise" -eq "1"
        then
            nr_search "$query"
            docs=`cat nr_search/part-00000`
            
            if [ "$docs" == "" ];then
                dialog --title ":(" --msgbox "No Anwer Find" 5 45
                    break
            elif [ "${docs:0:1}" == "!" ];then
                dialog  --yesno "did you mean : ${docs:1}?" 5 45
                if test $? -eq 0
                then    
                    query=${docs:1}
                    continue
                else
                    break
                fi
            else
                dialog --menu "retrived docs:" 15 40 4 $docs 2>selected_doc
                docnum=`cat selected_doc`
                dialog --yesno "`cat proj2/doc$docnum`" 100 100
                break
            fi
        elif test "$choise" -eq "2"
        then
            and_search "$query"
            docs=`cat and_search/part-00000`
            if [ "$docs" == "" ];then
                dialog --title ":(" --msgbox "No Anwer Find" 5 45
                break
            elif [ "${docs:0:1}" == "!" ];then
                dialog  --yesno "did you mean : ${docs:1}?" 5 45
                if test $? -eq 0
                then    
                    query=${docs:1}
                    continue
                else
                    break
                fi
            else
                dialog --menu "retrived docs:" 15 40 4 $docs 2>selected_doc
                docnum=`cat selected_doc`
                dialog --yesno "`cat proj2/doc$docnum`" 100 100
                break
            fi
        elif test "$choise" -eq "3"
        then
            ltn_search "$query"
            docs=`cat ltn_search/part-00000`
            if [ "$docs" == "" ];then
                dialog --title ":(" --msgbox "No Anwer Find" 5 45
                break
            elif [ "${docs:0:1}" == "!" ];then
                dialog  --yesno "did you mean : ${docs:1}?" 5 45
                if test $? -eq 0
                then    
                    query=${docs:1}
                    continue
                else
                    break
                fi
            else
                dialog --menu "retrived docs:" 15 40 4 $docs 2>selected_doc
                docnum=`cat selected_doc`
                dialog --yesno "`cat proj2/doc$docnum`" 100 100
                break
            fi
        elif test "$choise" -eq "4"
        then
            ltc_search "$query"
            docs=`cat ltc_search/part-00000`
            if [ "$docs" == "" ];then
                dialog --title ":(" --msgbox "No Anwer Find" 5 45
                break
            elif [ "${docs:0:1}" == "!" ];then
                dialog  --yesno "did you mean : ${docs:1}?" 5 45
                if test $? -eq 0
                then    
                    query=${docs:1}
                    continue
                else
                    break
                fi
            else
                dialog --menu "retrived docs:" 15 40 4 $docs 2>selected_doc
                docnum=`cat selected_doc`
                dialog --yesno "`cat proj2/doc$docnum`" 100 100
                break
            fi
        fi
    done

done