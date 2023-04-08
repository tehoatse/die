#!/usr/bin/env bash

quickmode=1
numberofdie=1
diespots=6

drumroll () {
    if [[ $# -gt 0 ]]; then
        announcement=$1
    else   
        announcement="Drumroll!"
    fi

    printf "%s\n" "$announcement"
    sleep 0.4
    echo "."
    sleep 0.4
    echo "."
    sleep 0.4
    echo "."
    sleep 0.4
}

getdie () {
    if [[ $1 =~ [0-9]d[0-9] ]]; then 
        numbers=${1/"d"/" "}
        numberofdie=$(echo $numbers | awk '{print $1}')
        diespots=$(echo $numbers | awk '{print $2}')
        #printf "%s \n%s \n" $numberofdie $diespots
    else
        echo "Unrecognised die format."
    fi
}

while getopts :d:n option; do
     case $option in
        d) getdie "$OPTARG";;
        n) quickmode=0;;
     esac
 done

heading=$(printf "Rolling %sd%s" $numberofdie $diespots)

if [[ $quickmode -lt 1 ]]; then
    echo "$heading"
else 
    drumroll "$heading"
fi

for ((i=1;i<=numberofdie;i++)); do
    output=$(( RANDOM % $diespots + 1))
    printf "%s " $output
done
    echo ""