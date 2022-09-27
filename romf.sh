#!/bin/bash
#!/bin/bash
#Konvertera tal till romerska siffror
#Numind- Number index, used to index the user-inputed number or numeral
numind=0
echo "V=5000, v=5; X=10000, x=10"
(clear)
echo "-----Roman numeral converter-----"

#Arrays containing values of the different base-ten numbers, 1-9, 10-90, and so on up to 9000
#Due to limitations in bash's ability to process characters, capital and non-capital letters must be used
ental_array=(I II III Iv v vI vII vII Ix)
tiotal_array=(x xx xxx xL L Lx Lxx Lxxx xC)
hundratal_array=(C CC CCC CD D DC DCC DCCC CM)
tusental_array=(M MM MMM MV V VM VMM VMMM MX)
#Declares an associated array, allows for value entry into array lookup, returning the index number, used for roman to arabic conversion
declare -A symbol_array
symbol_array=([I]=0 [v]=1 [x]=2 [L]=3 [C]=4 [D]=5 [M]=6 [V]=7 [X]=8)

#Allows the user to Convert another number
contq() {
    echo "Would you like to convert another number? (y/n)"
    read -r yn
    if [ "$yn" = "y" ]; then
        choose_conversion
    else
        echo "Okay, see you next time ;)"
        for _ in $(seq 1 5); do
            sleep 0.5
            echo "."
        done
        (clear)
        exit
    fi
}
#aind- Array index, takes the number from $num and uses it to search the arrays, assigns resulting numeral to respective variable
ental() {
    ((aind=${num:numlen-1:1}-1))
    xnum=${ental_array[aind]}
    #Checks if the Array-index is negative, which would return 9/90/900/9000, instead of an empty string
    if ((aind<0)); then
        xnum=""
    fi
}
tiotal() {
    ((aind=${num:numlen-2:1}-1))
    ynum=${tiotal_array[aind]}
    if ((aind<0)); then
        ynum=""
    fi
}
hundratal() {
    ((aind=${num:numlen-3:1}-1))
    znum=${hundratal_array[aind]}
    if ((aind<0)); then
        znum=""
    fi
}
tusental() {
    ((aind=${num:numlen-4:1}-1))
    tnum=${tusental_array[aind]}
    if ((aind<0)); then
        tnum=""
    fi
}
#Main function, runs the conversion functions and prints the result, also takes user input
convert_arabic_to_roman() {
    echo -e "\nPlease enter an arabic numeral(1-9999): "
    read -r num
    if ((num<1)) || ((num>9999)); then
        echo "Hey, you need to enter a number between 1-9999!"
        convert_arabic_to_roman
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
    contq
}
#Read the name :P
convert_roman_to_arabic() {
    echo -e "\nPlease enter a roman numeral to convert (!CASE-SENSITVE!) (1-48999)"
    read -r num
    numlen=${#num}
    #loop through all characters in the roman numeral
    while [ $numind -lt "$numlen" ]; do
        #Not ideal, but bash does not appreciate using indexes in an array arg
        symbol_one=${num:numind:1}
        symbol_two=${num:numind+1:1}
        #Checks if the number following is greater, if it is, subtract the value of the symbol from the total value
        #Returns "bad array subscript", but works?
        if [ "${symbol_array[$symbol_two]}" -gt "${symbol_array[$symbol_one]}" ]; then
            case ${num:numind:1} in
            I)
                ((total_value-=1))
                ;;
            v)
                ((total_value-=5))
                ;;
            x)
                ((total_value-=10))
                ;;
            L)
                ((total_value-=50))
                ;;
            C)
                ((total_value-=100))
                ;;
            D)
                ((total_value-=500))
                ;;
            M)
                ((total_value-=1000))
                ;;
            V)
                ((total_value-=5000))
                ;;
            X)
                ((total_value-=10000))
                ;;
            esac
        else
            case ${num:numind:1} in
            I)
                ((total_value+=1))
                ;;
            v)
                ((total_value+=5))
                ;;
            x)
                ((total_value+=10))
                ;;
            L)
                ((total_value+=50))
                ;;
            C)
                ((total_value+=100))
                ;;
            D)
                ((total_value+=500))
                ;;
            M)
                ((total_value+=1000))
                ;;
            V)
                ((total_value+=5000))
                ;;
            X)
                ((total_value+=10000))
                ;;
            esac
        fi
        #Numind- Number index, used to index the $num variable
        ((numind=numind+1))
        continue
    done
    echo "Total value is: $total_value"
}
#gives the user a choice on wheter or not to convert from arabic or roman numerals
choose_conversion() {
    echo -e "\nPlease choose conversion mode, input the numeric system you would like to convert from: Roman or Arabic (r/a)"
    read -r ra
    if [ "$ra" = "r" ]; then
        convert_roman_to_arabic
    else
        convert_arabic_to_roman
    fi
}
#initiates the program
choose_conversion