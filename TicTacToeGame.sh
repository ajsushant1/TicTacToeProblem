#!/bin/bash -x

echo "/******************************************* WELCOME TO TIC TAC TOE GAME *******************************************/"

# CONSTANTS
NUMBER_OF_ROWS=3
NUMBER_OF_COLUMNS=3

# VARIABLES
playerOneSign=0
playerTwoSign=0
playerOneTurn=0
playerTwoTurn=0
win=0
winnerPlayer=0
totalTurnCount=9
turnCount=0

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
		playerOneTurn=1
	else
		echo "Player Two Play First"
		playerTwoTurn=0
	fi
}

# FUNCTION TO DISPLAY GAME BOARD
function displayGameBoard(){
	echo "-------------"
	for (( row=0; row<$NUMBER_OF_ROWS; row++ ))
	{
		for (( column=0; column<$NUMBER_OF_COLUMNS; column++ ))
		{
			echo -ne " ${gameBoard[$row,$column]} |"
		}
		printf "\n"
		echo "-------------"
	}
}

# FUNCTION TO CHECK WINNING CONDITIONS
function checkWinCondition(){
	local sign=$1
	local winner=$2
	local diagonalFlag1=0
	local diagonalFlag2=0
	local verticalFlag=0
	local horizontalFlag=0
	for (( r=0; r<$NUMBER_OF_ROWS; r++ ))
	{
		horizontalFlag=0
		verticalFlag=0
		for (( c=0; c<$NUMBER_OF_COLUMNS; c++ ))
		{
			if [[ ${gameBoard[$r,$c]} == $sign ]]
			then
				((horizontalFlag++))
			fi
			if [[ ${gameBoard[$c,$r]} == $sign ]]
			then
				((verticalFlag++))
			fi
			if [[ $r == $c ]]
			then
				if [[ ${gameBoard[$r,$c]} == $sign ]]
				then
					((diagonalFlag1++))
				fi
			fi

		}
		if [[ ${gameBoard[$r,$(($NUMBER_OF_ROWS-$r-1))]} == $sign ]]
		then
			((diagonalFlag2++))
		fi

		if [[ $horizontalFlag -eq 3 || $verticalFlag -eq 3 || $diagonalFlag1 -eq 3 || $diagonalFlag2 -eq 3 ]]
		then
			win=1
			winnerPlayer=$winner
			break
		fi
	}
}

# FUNCTION TO GET POSITION OF PLAYER MOVE
function getPosition(){
	local sign=$1
	local rowPosition
	local columnPosition
	read -p "Enter row position :" rowPosition
   read -p "Enter column position :" columnPosition
	if [[ ${gameBoard[$rowPosition,$columnPosition]} == x || ${gameBoard[$rowPosition,$columnPosition]} == o ]]
	then
		echo "Position already occupied!!"
		getPosition $sign
	else
		gameBoard[$rowPosition,$columnPosition]=$sign
		((turnCount++))
	fi
}

resetGameBoard
assignSign
toss
echo "PlayerOneSign is :$playerOneSign "
echo "PlayerTwoSign is :$playerTwoSign "
displayGameBoard

# LOOP FOR SWITCH PLAYER TURN TILL WIN
while [ $win -ne 1 ]
do
	if [[ $turnCount -lt $totalTurnCount ]]
	then
		if [ $playerOneTurn -eq 1 ]
		then
			echo "Player One Turn "
			getPosition $playerOneSign
			displayGameBoard
			checkWinCondition $playerOneSign $playerOneTurn
			playerOneTurn=0
		else
			echo "Player Two Turn "
			getPosition $playerTwoSign
			displayGameBoard
			checkWinCondition $playerTwoSign $playerTwoTurn
			playerOneTurn=1
		fi
	else
		break
	fi
done

# TO DISPLAY WINNER PLAYER OR MATCH IS TIE
if [[ $winnerPlayer -eq 1 ]]
then
	echo "Player One is Winner"
elif [[ $winnerPlayer -eq 0 ]]
then
	echo "Player Two is Winner"
else
	echo "Match is tie"
fi
