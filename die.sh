#!/usr/bin/env bash

quickmode=1
printtotal=1

numberofdie=1
diespots=6
# declare -i dietotal
# dietotal=0

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

help () {
    printf '\n--help--'
    printf "\nRoll dice!\n\nIf no option given script will roll 1d6 and show the result\n\n"
    printf "\t-d\t allows you to roll more than one dice of different sides"
    printf "\n\t\t die.sh -d 1d4 will give you a number between 1 and 4"
    printf "\n\t\t die.sh -d 3d6 will roll 3d6 and give the result"
    printf "\n\n\t-n\t this option rolls the dice without the drum roll\n"
    printf "\n--done--\n\n"
    exit
}

while getopts :d:n option; do
     case $option in
        d) getdie "$OPTARG";;
        n) quickmode=0;;
        ?) help
     esac
 done

heading=$(printf "Rolling %sd%s" $numberofdie $diespots)

if [[ $quickmode -gt 0 ]]; then
    drumroll "$heading"
else 
    echo "$heading"
fi

for ((i=1;i<=numberofdie;i++)); do
    output=$(( RANDOM % $diespots + 1))
    printf "%s " $output
 #   dietotal+=$output
done

if [[ $printtotal -gt 0 ]]; then
    printf "\nThe total of the die is %s" $dietotal
fi

#echo "$dietotal"