#!/bin/bash
#dice1.sh
echo "hello there human!"
sleep 1
echo "or alien.."
sleep 1
echo "Welcome to my awesome-sawesome game!"
sleep 1
echo "first things first.."
bigname() {
    read input
    output=$(tr '[:lower:]' '[:upper:]' <<<"$input")
    echo "$output"
}
The_actual_game_mode() {
    oldhighscore=$(cat highscores.txt)
    if [ "$oldhighscore" = "" ]; then
        echo "no earlier highscore bro lololol get rekt bastard"
    else
        echo "Tidigarenamn:  $oldhighscore"
    fi
    saldo="1000"
    while true; do
        echo "Bet some money bro?"
        read bet
        if let "bet > $saldo"; then
            echo "no. you can't do that. why do you keep insulting me?"
            exit
        fi
        if let "bet < 1"; then
            echo "no, doesn't work, try again"
            exit
        fi
        echo
        if [ "$bet" = "666" ]; then
            echo "broski thats sus, are you the devil or something?"
        fi
        echo "Choose a number between  0 and six"
        read guess
        if let "$guess > 6"; then
            echo "come on, don't be sooo greedy!"
            exit 0
        fi
        if [ "$guess" = "5" ]; then
            echo "nice number! that's my lucky number actually.."
        fi
        if [ "$guess" = "0" ]; then
            echo "0 is not a valid number, dumbass."
        fi
        if let "saldo==oldhighscore"; then
            exit
        fi
        sleep 2
        let "dice=RANDOM%6+1"
        if [ "$guess" = "$dice" ]; then
            let "saldo=saldo+(bet*3)"
            echo "You have won! hooray! you did something right for once"
        else
            let "saldo=saldo-bet"
            echo "you lost. lol"
            echo "Try again next time! if you're not too discouraged, ofc.."
        fi
        echo "You have $saldo"
        echo "Woohoo!"
        if ((saldo>oldhighscore)); then 
            echo $saldo > highscores.txt;
        fi
    done
}
echo "What is your name?"
name=$(bigname)
echo "Hello $name, I'm dad!"
sleep 2
echo "sorry, I know that wasn't funny.."
sleep 2
echo "Anyways, how are you today? PS: pls answer with either good, bad or okay."
read answer
sleep 1
if [ "$answer" = "bad" ]; then
    echo "Oh, that's not so great to hear. I hope you feel better soon! :):)"
fi
if [ "$answer" = "good" ]; then
    echo "that's great! May it always be that way :)"
fi
if [ "$answer" = "okay" ]; then
    echo "oh nice! hope everything's okay as well <3"
fi
sleep 2
echo "Okay!"
echo "now onto the actual game!"
echo "choose between these three game modes: The actual game mode or slay mode or extreme game mode"
read answer
if [ "$answer" = "The actual game mode" ]; then
    The_actual_game_mode
fi
