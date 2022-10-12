from os import system, name
def clear():
        if name == 'nt':
                _ = system('cls')
        else:
                _ = system('clear')
clear()
print("Welcome to tic tac toe!")
print("This is a two-player game, the first player to move is 'X', followed by 'O'.")
print("Try to be the first player to make a row of three symbols!")
# Arrays containing empty values, comprising the board
x_array = [" ", " ", " "]
y_array = [" ", " ", " "]
z_array = [" ", " ", " "]
Player = "X"
turn = 1

# Simply assigning the direction variable since it needs to be global, and is only used in is_won
Direction = None
def play_again():
    global x_array, y_array, z_array, Player, turn
    yn = input("Would you like to play again?\n")
    if yn=='y' or yn=='Y' or yn=='Yes':
        x_array = [" ", " ", " "]
        y_array = [" ", " ", " "]
        z_array = [" ", " ", " "]
        Player = "X"
        turn = 1
        # Simply assigning the direction variable since it needs to be global, and is only used in is_won
        Direction = None
        game()
    else:
        print("Sad to see you go :(")
        exit()


def game():
    def is_won(last_player): # is_won, check if the board has come to a "win" state (horizontally, diagonally, or vertically))
        global Direction
        # Checks for vertical wins, because of the way python handles arrays this can be done using a for-loop
        for i in range(3):
            if x_array[i] == y_array[i] == z_array[i] == last_player:
                Direction = "vertically"
                return True
            else:
                Direction = "horizontally"
        # Checks for horizontal wins, using indexes of the arrays to check for similarity. Could be done using a for loop, but this is faster
        if x_array[0] == x_array[1] == x_array[2] == last_player:
            return True
        elif y_array[0] == y_array[1] == y_array[2] == last_player:
            return True
        elif z_array[0] == z_array[1] == z_array[2] == last_player:
            return True
        # Checks for diagonal wins, this code is more "hand-written", because of the indicies
        if x_array[0] == y_array[1] == z_array[2] == last_player:
            Direction = "Diagonally"
            return True
        elif x_array[2] == y_array[1] == z_array[0] == last_player:
            Direction = "Diagonally"
            return True

    # Checks for a totally full board; since this will always run after win_or_loss, no false positives will appear

    def is_board_full():
        total = 0
        # Checks if all indices of the arrays have values, apart from their default value, if they do, the function returns True
        for i in range(3):
            if x_array[i] != " ":
                total += 1
            if y_array[i] != " ":
                total += 1
            if z_array[i] != " ":
                total += 1
        if total == 9:
            return True

    # Checks if the move the player made is legal, if it is not, it promts another movement input.

    def checkmove(box, array, xm):
        global Player, x_array, y_array, z_array
        if box != " ":
            print("That box is already occupied!!")
            makemove()
        else:
            # assigns the player value to the array in which the move was made
            array[int(xm)-1] = Player

    # Prints the playing feild, ie just all the arrays

    def printboard(won):
        global x_array, y_array, z_array
        print(x_array[0], x_array[1], x_array[2], sep=" | ")
        print("--+---+--")
        print(y_array[0], y_array[1], y_array[2], sep=" | ")
        print("--+---+--")
        print(z_array[0], z_array[1], z_array[2], sep=" | ")
        if won != 1:
            makemove()

    # The "main" function, calls all other functions and decides which player's turn it is

    def makemove():
        global xm, ym, Player, turn
        # If the turn number is even, then it is 'O's turn, otherwise X
        if (turn % 2) == 0:
            Player = "O"
        else:
            Player = "X"
        print("Player: " + Player)
        # Takes move input
        xm = int(input("Which column?\n"))
        ym = int(input("Which row?\n"))
        # Passes the move with checkmove(), which then assigns values, unless the square is already filled
        if 1 > ym or xm > 3:  # Checks for invalid coordinates, prompts a new move
            print("Please enter valid coordinates (1-3)")
            makemove()
        elif ym == 1:
            checkmove(x_array[xm-1], x_array, xm)
        elif ym == 2:
            checkmove(y_array[xm-1], y_array, xm)
        elif ym == 3:
            checkmove(z_array[xm-1], z_array, xm)
        # Passes the player value into is_won, if it returns true, prints the final board and announces the winner
        else:
            print("You didn't enter an interger, did you?")
            makemove()
        if is_won(Player):
            clear()
            print("The game has been won by " + Player + ", moving " + Direction)
            print("Final board: \n")
            printboard(1)
            play_again()
        # Checks if a tie has been reached
        if is_board_full():
            clear()
            print("Oh no, it seems we have reached a tie :(\n Final board: ")
            printboard(1)
            play_again()
        turn += 1
        printboard(0)

    # initiates the game
    printboard(0)
    makemove()


game()
