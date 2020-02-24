#!/bin/bash -x

echo "/******************************************* WELCOME TO TIC TAC TOE GAME *******************************************/"

# CONSTANTS
NUMBER_OF_ROWS=3
NUMBER_OF_COLUMNS=3

# DECLARING DICTIONARY FOR GAME
declare -A gameBoard

# FUNCTION TO RESET GAME BOARD
function resetGameBoard(){
	for (( row=0; row<$NUMBER_OF_ROWS; row++ ))
	do
		for ((column=0; column<$NUMBER_OF_COLUMNS; column++ ))
		do
			gameBoard[$row,$column]=" "
		done
	done
}

resetGameBoard
