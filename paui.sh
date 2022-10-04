#!/bin/bash
#dice1.sh a wacky dice game

#(clear)

let saldo="1000"

LCYAN='\033[1;36m' #light cyan
NC='\033[0m' #no color, reset to default (white)
CYAN='\033[0;36m' #cyan
YELLOW='\033[1;33m' #yellow
UCYAN='\033[4;36m' #underline cyan

echo -e "${UCYAN}How to play:"
echo
echo -e "${CYAN}Bet money, choose a number and roll the dice!"
echo -e "${YELLOW}Choose 0${CYAN} to view highscore and exit the game"
echo -e "So enjoy enjoy :>${NC}"
echo
echo -e "${LCYAN}Now... HEJA HEJA!${NC}"
echo
sleep 1

hs() {
highscore=$(cat list.txt)
if [ "$highscore" = "" ]; then
echo
echo "No previous highscore"
else
echo
echo "Previous highscore: $highscore"
fi

if let "highscore<saldo"; then
echo "New highscore: $saldo"
echo "Ayo a new highscore!"
echo "$saldo" > list.txt
else let "highscore<saldo";
echo "No new highscore"
fi
}

while true; do
echo "Current saldo: $saldo"
echo "Bet your money:"
read bet

if let "bet>saldo"; then
echo "You ain't got that money..."
sleep 2
echo "C'mon bet again:"
read bet
fi


if let "bet<1"; then
echo "Brokeass"
exit 1
else let "bet<=saldo";
echo
fi

echo "Choose a number between 0 and 6:"
read guess
echo
echo "Rolling the dice..."
sleep 2

let "dice=RANDOM % 6 +1"

if [[ "$guess" = "0" ]]; then
echo
echo "Stopping the dice!"
hs
exit 0
elif [[ "$guess" -lt "0" ]]; then
echo "Too low"
sleep 1
echo "C'mon choose again:"
read guess
elif let "guess>6"; then
echo "Too high"
sleep 1
echo "C'mon choose again:"
read guess
else
echo
fi

if [[ "$guess" == "$dice" ]]; 
then
    ((saldo+=bet*3))
    echo "Guess: $guess"
    echo "Dice: $dice"
    echo "Saldo: $saldo"
    echo -e "${YELLOW}Congrats bro${NC}"
    echo
    ((saldo=saldo-bet))
    echo "Guess: $guess"
    echo "Dice: $dice"
    echo "Saldo: $saldo"
    echo -e "${YELLOW}That's sad bro${NC}"
    echo
fi

if let "saldo==0"; then
sleep 1
echo -e "${CYAN}rip lol${NC}"
break
fi

done

echo -e "${LCYAN}Good game${NC}"
