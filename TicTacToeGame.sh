#!/bin/bash -x

echo "/******************************************* WELCOME TO TIC TAC TOE GAME *******************************************/"

# CONSTANTS
NUMBER_OF_ROWS=3
NUMBER_OF_COLUMNS=3

# VARIABLES
playerOneSign=0
playerTwoSign=0

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

# FUNCTION TO ASSIGN SIGN TO PLAYERS
function assignSign(){
	local randomValue=$((RANDOM%2))
	if [ $randomValue -eq 1 ]
	then
		playerOneSign=x
		playerTwoSign=o
	else
		playerOneSign=o
		playerTwoSign=x
	fi
}

# FUNCTION CHECK WHO PLAY FIRST
function toss(){
	local randomValue=$((RANDOM%2))
	if [ $randomValue -eq 1 ]
	then
		echo "Player One Play First"
	else
		echo "Player Two Play First"
	fi
}

resetGameBoard
assignSign
toss
