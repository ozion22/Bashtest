#!/bin/bash
#Konvertera tal till romerska siffror
fnum=""
echo "V=5000, v=5; X=10000, x=10"
(clear)
echo -e "-----Roman numeral converter-----\n"
#Arrays containing values of the different base-ten numbers, 1-9, 10-90, and so on up to 9000
#Due to limitations in bash's ability to process characters, capital and non-capital letters must be used
ental_array=(I II III IV v vI vII vII Ix)
tiotal_array=(x xx xxx xL L Lx Lxx Lxxx xC)
hundratal_array=(C CC CCC CD D DC DCC DCCC CM)
tusental_array=(M MM MMM MV V VM VMM VMMM MX)
#Allows the user to Convert another number
contconversion(){
        echo "Would you like to convert another number? (y/n)"
        read yn
        if [ "$yn" = "y" ]; then
                convert
        else
                echo "Okay, see you next time ;)"
                for x in $(seq 1 5) 
                do
                    sleep 0.5
                    echo "."
                done
                (clear)
                exit
        fi
}
#aind- Array index, takes the number from $num and uses it to search the arrays, assigns resulting numeral to respective variable
ental(){
    let "aind=${num:numlen-1:1}-1"
    xnum=${ental_array[aind]}
    #Checks if the Array-index is negative, which would return 9/90/900/9000, instead of an empty string
    if let "aind<0"; then
        xnum=""
    fi
}
tiotal(){
    let "aind=${num:numlen-2:1}-1"
    ynum=${tiotal_array[aind]}
    if let "aind<0"; then
        ynum=""
    fi
}
hundratal(){
    let "aind=${num:numlen-3:1}-1"
    znum=${hundratal_array[aind]}
    if let "aind<0"; then
        znum=""
    fi
}
tusental(){
    let "aind=${num:numlen-4:1}-1"
    tnum=${tusental_array[aind]}
    if let "aind<0"; then
        tnum=""
    fi
}
#Main function, runs the conversion functions and prints the result, also takes user input
convert(){
    echo -e "\nPlease enter an arabic numeral(1-9999): "
    read num
    #Checks for validity of $num
    if let "num<1" || let "num>9999"; then
        echo "Hey, you need to enter a number between 1-9999!"
        convert
    fi
    #Returns the lenght of the entered number, which is used for indexing
    numlen=${#num}
    #Calls functions based on length of number to be converted
    case $numlen in
        1)
            ental
            echo "$num is written as: $xnum"
        ;;
        2)
            ental
            tiotal
            echo "$num is written as: $ynum$xnum"
        ;;
        3)
            ental
            tiotal
            hundratal
            echo "$num is written as: $znum$ynum$xnum"
        ;;
        4)
            ental
            tiotal
            hundratal
            tusental
            echo "$num is written as: $tnum$znum$ynum$xnum"
        ;;
    esac
    contconversion
}
convert