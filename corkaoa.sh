#!/bin/bash
#dice1.sh
echo "hello there human!"
echo "or alien.."
echo "Welcome to my awesome-sawesome game!"
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
        echo "Earlier Highscore:  $oldhighscore"
    fi
    saldo="1000"
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
        echo "are you the devil or something?"
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
    if ((saldo > oldhighscore)); then
        echo $saldo >highscores.txt
    fi
    cont
}
slay_mode() {
    echo "hello there!"

    echo "I see.. you have great taste in game modes"

    echo "anyways.."

    saldo="66666"
        echo "fine. okay. bet some money, $name"
        read bet

        echo "wanna roll some dice?"

        echo "I will give you two choices.."

        echo "yes or yes"
        read answer

        if [ "$answer" = "yes" ]; then
            echo "rolling dice.."
        fi
        echo "wait!"

        echo "choose a number between 1 to 5"
        read number

        echo "okay.."

        echo "rolling dice.."
        let "dice=RANDOM%5+1"
        if [ "$number" = "$dice" ]; then
            let "saldo=saldo+(bet*666666666666)"
            echo "you won!"
        else
            let "saldo=saldo-bet"
            echo "you lost..sorry.."

            echo ":/"
        fi
        echo "you have $saldo"
        echo "slay!"

    cont
}
extreme_game_mode() {
    echo "I see..you're truly..."

    echo "something."

    echo "okay anyways.."

    echo "bet some money, bruh"
    read bet

    echo "really...?"

    echo "that's all you got?"

    echo "how weak bro."

    echo "bet another number! bigger than that!"
    echo "like come on!"
    read number
    if [ "$number" -lt "$bet" ]; then
        echo "seriously?"

        echo "I give up"
        exit
    fi
    if [ "$number" -gt "$bet" ]; then
        echo "finally..a.."

        echo "more acceptable number.."
    fi
    cont
}
echo "What is your name?"
name=$(bigname)
echo "Hello $name, I'm dad!"
echo "sorry, I know that wasn't funny.."
echo "Anyways, how are you today? PS: pls answer with either good, bad or okay."
read answer
if [ "$answer" = "bad" ]; then
    echo "Oh, that's not so great to hear. I hope you feel better soon! :):)"
fi
if [ "$answer" = "good" ]; then
    echo "that's great! May it always be that way :)"
fi
if [ "$answer" = "okay" ]; then
    echo "oh nice! hope everything's okay as well <3"
fi
echo "Okay!"
echo "now onto the actual game!"
echo "choose between these three game modes: actual game mode or slay mode or extreme game mode"
echo "By the way..."
echo "do you want to know more about any of these game modes? (PS!: please answer with yes or no)"
read answer
if [ "$answer" = "no" ]; then

    echo "Alright then.."

    echo "your choice after all.."

    echo "choose between three game modes: The actual game mode or slay mode or extreme game mode"
fi
if [ "$answer" = "yes" ]; then

    echo "Very well then, $name!"

    echo "the actual game mode is the main game mode where you bet a number and roll a dice and you either win or lose"

    echo "then slay mode is endless, where doubled the wins, and the same amount of losses.!"

    echo "yes.. you heard me right.."

    echo "you win way more!"

    echo "then extreme game mode is the best mode of all the previous game modes!"

    echo "best..?!"

    echo "yes!"

    echo "you only win! no consequences!"

    echo "choose between three game modes: The actual game mode or slay mode or extreme game mode"
fi
read answer
if [ "$answer" = "The actual game mode" ]; then
    The_actual_game_mode
fi
if [ "$answer" = "slay mode" ]; then
    slay_mode
fi
if [ "$answer" = "extreme game mode" ]; then
    extreme_game_mode
fi
cont() {
    echo "Would you like to play again?"
    read yn
    if [ "$yn" == "y" ]; then
        echo "Which game mode? normal(1), slay(2), extreme(3)"
        read game_mode
        case $game_mode in
        1)
            The_actual_game_mode
            ;;
        2)
            slay_mode
            ;;
        3)
            extreme_game_mode
            ;;
        *)
            cont
            ;;
        esac
    else
        exit
    fi
}
