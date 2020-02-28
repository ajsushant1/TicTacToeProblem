#!/bin/bash -x

echo "/******************************************* WELCOME TO TIC TAC TOE GAME *******************************************/"

# CONSTANTS
NUMBER_OF_ROWS=3
NUMBER_OF_COLUMNS=3
EMPTY=" "

# VARIABLES
playerSign=0
computerSign=0
playerTurn=0
computerTurn=0
win=0
winnerPlayer=0
totalTurnCount=9
turnCount=0
isAvailable=0

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
		playerSign=x
		computerSign=o
	else
		playerSign=o
		computerSign=x
	fi
}

# FUNCTION CHECK WHO PLAY FIRST
function toss(){
	local randomValue=$((RANDOM%2))
	if [ $randomValue -eq 1 ]
	then
		echo "Player Play First"
		playerTurn=1
	else
		echo "Computer play First"
		playerTurn=2
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
	local flagCount=3
	local diagonalFlag1=0
	local diagonalFlag2=0
	local verticalFlag=0
	local horizontalFlag=0
	for (( row=0; row<$NUMBER_OF_ROWS; row++ ))
	{
		horizontalFlag=0
		verticalFlag=0
		for (( column=0; column<$NUMBER_OF_COLUMNS; column++ ))
		{
			# CHECKING HORIZONTAL WINNING CONDITION
			if [[ ${gameBoard[$row,$column]} == $sign ]]
			then
				((horizontalFlag++))
			fi
			# CHECKING VERTICAL WINNING CONDITION
			if [[ ${gameBoard[$column,$row]} == $sign ]]
			then
				((verticalFlag++))
			fi
			# CHECKING DIAGONAL WINNING CONDITION
			if [[ $row == $column ]]
			then
				if [[ ${gameBoard[$row,$column]} == $sign ]]
				then
					((diagonalFlag1++))
				fi
			fi

		}
		if [[ ${gameBoard[$row,$(($NUMBER_OF_ROWS-$row-1))]} == $sign ]]
		then
			((diagonalFlag2++))
		fi

		if [[ $horizontalFlag -eq $flagCount || $verticalFlag -eq $flagCount || $diagonalFlag1 -eq $flagCount || $diagonalFlag2 -eq $flagCount ]]
		then
			win=1
			winnerPlayer=$winner
			break
		fi
	}
}

# CHECKING WINNING POSIBILITIES
function checkWinPosibility(){
local sign=$1
local row=0
local column=0

# VERTICAL POSIBILITIES
	for (( row=0; row<$NUMBER_OF_COLUMNS; row++ ))
	{
		if [[ ${gameBoard[$row,$column]} == $EMPTY && ${gameBoard[$row,$(($column+1))]}${gameBoard[$row,$(($column+2))]} == $sign$sign ]]
		then
			gameBoard[$row,$column]=$computerSign
			isAvailable=1
			return
		elif [[ ${gameBoard[$row,$(($column+1))]} == $EMPTY && ${gameBoard[$row,$column]}${gameBoard[$row,$(($column+2))]} == $sign$sign ]]
		then
			gameBoard[$row,$(($column+1))]=$computerSign
			isAvailable=1
			return
		elif [[ ${gameBoard[$row,$(($column+2))]} == $EMPTY && ${gameBoard[$row,$column]}${gameBoard[$row,$(($column+1))]} == $sign$sign ]]
		then
			gameBoard[$row,$(($column+2))]=$computerSign
			isAvailable=1
			return
		fi
	}

# HORIZONTAL POSIBILITIES
row=0
column=0
	for (( column=0; column<$NUMBER_OF_COLUMNS; column++ ))
	{
		if [[ ${gameBoard[$row,$column]} == $EMPTY && ${gameBoard[$(($row+1)),$column]}${gameBoard[$(($row+2)),$column]} == $sign$sign ]]
		then
			gameBoard[$row,$column]=$computerSign
			isAvailable=1
			return
		elif [[ ${gameBoard[$(($row+1)),$column]} == $EMPTY && ${gameBoard[$row,$column]}${gameBoard[$(($row+2)),$column]} == $sign$sign ]]
		then
			gameBoard[$(($row+1)),$column]=$computerSign
			isAvailable=1
			return
		elif [[ ${gameBoard[$(($row+2)),$column]} == $EMPTY && ${gameBoard[$row,$column]}${gameBoard[$(($row+1)),$column]} == $sign$sign ]]
		then
			gameBoard[$(($row+2)),$column]=$computerSign
			isAvailable=1
			return
		fi
	}

# DIAGONAL POSIBILITIES
row=0
column=0
		if [[ ${gameBoard[$row,$column]} == $EMPTY && ${gameBoard[$(($row+1)),$(($column+1))]}${gameBoard[$(($row+2)),$(($column+2))]} == $sign$sign ]]
		then
			gameBoard[$row,$column]=$computerSign
			isAvailable=1
			return
		elif [[ ${gameBoard[$(($row+1)),$(($column+1))]} == $EMPTY && ${gameBoard[$row,$column]}${gameBoard[$(($row+2)),$(($column+2))]} == $sign$sign ]]
		then
			gameBoard[$(($row+1)),$(($column+1))]=$computerSign
			isAvailable=1
			return
		elif [[ ${gameBoard[$(($row+2)),$(($column+2))]} == $EMPTY && ${gameBoard[$row,$column]}${gameBoard[$(($row+1)),$(($column+1))]} == $sign$sign ]]
		then
			gameBoard[$(($row+2)),$(($column+2))]=$computerSign
			isAvailable=1
			return
		fi
row=0
column=0
		if [[ ${gameBoard[$row,$(($column+2))]} == $EMPTY && ${gameBoard[$(($row+1)),$(($column+1))]}${gameBoard[$(($row+2)),$column]} == $sign$sign ]]
		then
			gameBoard[$row,$(($column+2))]=$computerSign
			isAvailable=1
			return
		elif [[ ${gameBoard[$(($row+1)),$(($column+1))]} == $EMPTY && ${gameBoard[$row,$(($column+2))]}${gameBoard[$(($row+2)),$column]} == $sign$sign ]]
		then
			gameBoard[$(($row+1)),$(($column+1))]=$computerSign
			isAvailable=1
			return
		elif [[ ${gameBoard[$(($row+2)),$column]} == $EMPTY && ${gameBoard[$(($row+1)),$(($column+1))]}${gameBoard[$row,$(($column+2))]} == $sign$sign ]]
		then
			gameBoard[$(($row+2)),$column]=$computerSign
			isAvailable=1
			return
		fi
}

# FUNCTION TO CHECK CORNERS
function checkCorner(){
	local rowPosition=0
	local columnPosition=0
	local count=0
	local numberOfCorners=4
	while [[ $count -lt $numberOfCorners ]]
	do
		rowPosition=$((RANDOM%$NUMBER_OF_ROWS))
		columnPosition=$((RANDOM%$NUMBER_OF_ROWS))
		echo "$rowPosition $columnPosition"
		if [[ $(((($rowPosition+$columnPosition))%2)) == 0 && $columnPosition != 1 ]]
		then
			((count++))
			if [[ ${gameBoard[$rowPosition,$columnPosition]} == $EMPTY ]]
			then
				gameBoard[$rowPosition,$columnPosition]=$computerSign
				isAvailable=1
         	break
			fi
		fi
	done
}


resetGameBoard
assignSign
toss
echo "PlayerOneSign is :$playerSign "
echo "Computer Sign is :$computerSign "
displayGameBoard

# LOOP FOR SWITCH PLAYER TURN TILL WIN
while [ $win -ne 1 ]
do
	if [[ $turnCount -lt $totalTurnCount ]]
	then
		if [ $playerTurn -eq 1 ]
		then
			read -p "Enter row position :" rowPosition
			read -p "Enter column position :" columnPosition
			while [[ ${gameBoard[$rowPosition,$columnPosition]} != $EMPTY ]]
			do
				echo "Position already occupied!!"
				read -p "Enter row position :" rowPosition
				read -p "Enter column position :" columnPosition
			done
			gameBoard[$rowPosition,$columnPosition]=$playerSign
			displayGameBoard
			checkWinCondition $playerSign $playerTurn
			((turnCount++))
			playerTurn=2
		else
			isAvailable=0
			echo "Computer Turn "
			checkWinPosibility $computerSign
			if [ $isAvailable -eq 0 ]
			then
				checkWinPosibility $playerSign
			fi
			if [ $isAvailable -eq 0 ]
			then
				checkCorner
			fi
			if [ $isAvailable -eq 0 ]
			then
				rowPosition=$((RANDOM%$NUMBER_OF_ROWS))
				columnPosition=$((RANDOM%$NUMBER_OF_ROWS))
				while [[ ${gameBoard[$rowPosition,$columnPosition]} != $EMPTY ]]
				do
					rowPosition=$((RANDOM%$NUMBER_OF_ROWS))
					columnPosition=$((RANDOM%$NUMBER_OF_ROWS))
				done
				gameBoard[$rowPosition,$columnPosition]=$computerSign
			fi
			((turnCount++))
			displayGameBoard
			checkWinCondition $computerSign $playerTurn
			playerTurn=1
		fi
	else
		break
	fi
done

# TO DISPLAY WINNER PLAYER OR MATCH IS TIE
if [[ $winnerPlayer -eq 1 ]]
then
	echo "Player One is Winner"
elif [[ $winnerPlayer -eq 2 ]]
then
	echo "Computer is Winner"
else
	echo "Match is tie"
fi
