#!/bin/bash
mysleep() {
    let "debug=0"
    if let "debug==0"; then
        sleep $1
    fi
}
let "Chances=10"

oldname=$(cat highscore.txt)
echo "Highscore:$oldname"

echo "You are throwing a dice"
mysleep 1
echo "You have ten chances"
mysleep 2
echo "You guess between numbers 1-6 "
echo "Every time you win you get one chance"
mysleep 2
echo "But"
mysleep 2
echo "Everytime you lose you lose one chance"
mysleep 2
echo "The objective is to get as many points as possible"
mysleep 2
echo "Good luck!!!"
mysleep 1

while true; do

    echo "guess:"
    read guess
    if [ "$guess" = "0" ]; then
        echo "Choose between 1-6 next time"
        exit
    else
        mysleep 2
    fi

    if let "$guess>6"; then
        mysleep 1
        echo "You didnt follow the instructions!!!"
        exit
    fi

    let "max=6"
    let "dice=RANDOM % max + 1"

    echo "Im guessing $dice"
    mysleep 2

    if let "dice==score"; then
        let "score=Chances+1"
        echo "Congrats"
        echo "You have $score chances left"
    else
        let "score=Chances-1"
        echo "Thats bad, but try again"
        echo "You have $score chances left."
    fi
    mysleep 2

    let "Chances=score"
    echo "You have $Chances chances left"
    oldname=$(cat highscore.txt)
    if (($Chances>$oldname)); then
        echo "$Chances" >highscore.txt
    else
        echo "$oldname" >highscore.txt
    fi
    let "great=0"
    if let "Chances==great"; then
        echo "GAME OVER"
        exit
    else
        if let "$Chances>10"; then
            echo "YOU WIN"
            exit
        fi
    fi
done
exit
