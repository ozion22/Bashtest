#!/bin/bash
#TicTacToe...
#Allows the players to play again
#args: none
echo "Welcome to tic tac toe!"
echo "This is a two-player game for now, feel free to play with a friend!"
for ((i=0;i<11;i++)); do
        sleep 0.5
        echo "."
done
PlayAgain() {
    echo "Would you like to play again?"
    read -r yn
    if [ "$yn" = "y" ] || [ "$yn" = "Y" ] || [ "$yn" = "yes" ]; then
        turn=1
        row_1=("." "." ".")
        row_2=("." "." ".")
        row_3=("." "." ".")
        game
    else
        echo "Sad to see you go :("
        exit
    fi
}
#The main function, provides structure
#Args: none
game() {
    declare -a row_1
    declare -a row_2
    declare -a row_3
    row_1=("." "." ".")
    row_2=("." "." ".")
    row_3=("." "." ".")
    player="X"
    turn=1
    #Simply prints the board
    printboard() {
        (clear)
        echo -e "$1"
        echo "==========="
        echo -e " ${row_1[0]} | ${row_1[1]} | ${row_1[2]}\n---+---+---\n ${row_2[0]} | ${row_2[1]} | ${row_2[2]}\n---+---+---\n ${row_3[0]} | ${row_3[1]} | ${row_3[2]}"
        echo "==========="
    }
    #Checks if a tie has been reached using the turn number
    #args: none
    isTie() {
        if [ "$turn" -gt "9" ]; then
            printboard "We have reached a tie!\nFinal Board:"
            sleep 2
            PlayAgain
        fi
    }
    #Checks for a win
    #Args: none
    check_win() {
        row_1_total=0
        row_2_total=0
        row_3_total=0
        #Iterates over all indexs in only one list at a time, adds to a running total defined above
        for ((i = 0; i < 3; i++)); do
            if [ "${row_1[$i]}" = "$player" ]; then
                ((row_1_total += 1))
            fi
            if [ "${row_2[$i]}" = "$player" ]; then
                ((row_2_total += 1))
            fi
            if [ "${row_3[$i]}" = "$player" ]; then
                ((row_3_total += 1))
            fi
        done
        #If three of the Player's characters are detected in a row, calls win_print
        if [[ "$row_1_total" == 3 || "$row_2_total" == 3 || "$row_3_total" == 3 ]]; then
            win_print "horizontally"
        fi
        #Iterates over the indexes of all rows, returning true if all for a certain interation match, in that case win_print is called, ending the game
        for ((j = 0; j < 3; j++)); do
            if [ "${row_1[$j]}" = "${row_2[$j]}" ] && [ "${row_2[$j]}" = "${row_3[$j]}" ] && [ "${row_1[$j]}" = "$player" ]; then
                win_print "vertically"
            fi
        done
        #Checks for diagonal wins
        if [[ "${row_1[0]}" == "$player" && "${row_2[1]}" == "$player" && ${row_3[2]} == "$player" ]]; then
            win_print "diagonally"
        elif [[ "${row_1[2]}" == "$player" && "${row_2[1]}" == "$player" && ${row_3[0]} == "$player" ]]; then
            win_print "diagonally"
        fi
    }
    #Handles everything that needs to happen if a win is true
    #args: Direction (str)
    win_print(){
        (clear)
        printboard
        echo "Player: $player wins $1!"
        sleep 2
        PlayAgain
    }
    #Checks if a move is legal, also checks if it results in a tie or a win
    #args : Column (int), Row (int)
    checkmove() {
        #$1 is in 1-3, arrays are index 0-2
        adjusted_column=$1
        ((adjusted_column -= 1))
        #Checks legality based on row
        case $2 in
        1)
            if [ "${row_1[$adjusted_column]}" != "." ]; then
                echo "!That place is already occupied!"
                makemove
            else
                row_1[$adjusted_column]="$player"
            fi
            ;;
        2)
            if [ "${row_2[$adjusted_column]}" != "." ]; then
                echo "That place is already occupied!"
                makemove
            else
                row_2[$adjusted_column]=$player
            fi
            ;;
        3)
            if [ "${row_3[$adjusted_column]}" != "." ]; then
                echo "That place is already occupied!"
                makemove
            else
                row_3[$adjusted_column]=$player
            fi
            ;;
        esac
        check_win
    }
    #Allows players to input a move
    makemove() {
        #Calls isTie to prevent recursive loop
        isTie
        printboard
        #Decides which player's turn it is
        if ((turn % 2 == 0)); then
            player="X"
        else
            player="O"
        fi
        echo "Player: $player"
        echo "-----------"
        echo "Which column?"
        read -r column
        echo "Which row?"
        read -r row
        #Checks so that coordinates are within feild
        if [ "$column" -gt 3 ] || [ "$row" -gt 3 ] || [ "$row" -lt 1 ] || [ "$column" -lt 1 ]; then
            column=""
            row=""
            echo "Invalid coordinates! Please enter valid ones! (1-3)"
            sleep 1
            makemove
        fi
        #Calls checkmove
        checkmove $column $row
        ((turn += 1))
        #Reiterates over itself
        makemove
    }
    #Calles makemove to start the game
    makemove
}
#Calls game to start the game
game
