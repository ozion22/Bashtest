#!/bin/bash
#Dice1
(clear)
saldo=1000
echo -ne "\n--------Welcome, enter *hl* in the bet feild to enter higher or lower, Or enter *t* to see your total saldo--------\n"
chkh() {
        high=$(cat highscore.txt)
}
chkh
#^^Checks highscore
help() {
        echo "Enter 'hl' in the bet feild to enter higher or lower"
        echo "Your starting saldo is shown before and after ever game "
}
hol() {
        (clear)
        echo -e "\n--------   Higher or Lower   --------\n"
        ((hl=RANDOM%10 +1))
        #Generates random number from 1 to 10
        echo "How much would you like to bet?"
        read -r bet
        echo "Is the number higher or lower than 5?"
        read -r usrhl
        if ((hl>=5)); then
                ((h2=1))
        else
                ((h2=0))
        fi
        #Checks if the number is higher or lower than 5
        if [ "$usrhl" = "h" ]; then
                ((usrhl=1))
        else
                ((usrhl=0))
        fi
        #interperets user guess
        if ((usrhl==h2)); then
                ((saldo=saldo+bet*2))
                echo "You won!, your saldo is now $saldo"
        else
                ((saldo=saldo-bet))
                echo "You didn't guess correctly :( Your saldo is now $saldo"
        fi
        #Victory and loss conditions
        echo "Would you like to play again?"
        read -r yn
        if [ "$yn" = "y" ]; then
                #Continues the game
                hol
        else
                #Returns to dice roll
                (clear)
                diceroll
        fi
}
#Repeats the game
diceroll() {
        (clear)
        echo -e "\nEnter *hl* in the bet feild to enter higher or lower"
        echo -e "\n--------\tDice Roll\t--------\n"
        echo "Please place your bet"
        read -r bet

        if [ "$bet" = "hl" ]; then
                hol
        elif [ "$bet" = "t" ]; then
                echo "Your total is $saldo"
                echo "Please place your bet"
                read -r bet
        fi
        #^^Highorlow entry &total check
        if ((bet<=0)); then
                echo "You have to bet more than 0kr!"
                echo "Please place your bet"
                read -r bet
        fi
        if ((bet>saldo));then
                echo "You can't bet more than you have!"
                echo "Please place your bet"
                read -r bet
        fi
        #^^ Places bet and determins validity

        ((dice=RANDOM%6 +1))
        #^^Generates random number between 1 and 6
        echo "Please guess a number between 1 and 6"
        read -r guess
        #^^Reads guess and bet
        if ((guess==0)); then
                #provides program-exit
                echo "Goodbye"
                exit
        fi
        if ((1>guess)); then
                echo "Please guess a number that is posible ;)"
                echo "Enter Guess(1-6)"
                read -r guess
        else
                if ((6<guess)); then
                        echo "Please guess a number that is possible ;)"
                        echo "Enter Guess(1-6)"
                        read -r guess
                fi
        fi
        #^^Checks guess for incorrect numbers
        sleep 2
        if ((dice==guess)) ; then
                #correct guess
                ((saldo=saldo+bet*3))
                echo "You won!"
                echo "Your total is now $saldo"
        else
                #Incorrect guess
                echo "You lost"
                ((saldo=saldo-bet))
                echo "Your total is now $saldo"
        fi
        sleep 3
        diceroll
}
diceroll
while true; do
        if ((saldo<=0)); then
                #provides a loss-condition
                echo "You went bust :("
                exit
        fi
        if ((saldo>=high)); then
                echo "$saldo" > highscore.txt
                echo "New High score! $saldo"
                chkh
        fi
        #^^ Checks and assigns new highscore

done
