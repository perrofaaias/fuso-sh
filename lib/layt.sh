#!/bin/bash

source "$FUSO_HOME/lib/util.sh"

# boundary(step, length)
# ----------------------
# Indicates the position of [step] between 1 (inclusive) and [length]
# (inclusive):
# 0, first edge; 1, between edges; 2, limit (second edge).
boundary() {
  if [[ $1 -eq 1 ]]; then
    printf 0
  elif [[ $1 -lt $2 ]]; then
    printf 1
  else
    printf 2
  fi
}

# move(row, column)
# -----------------
# Moves the cursor down [row] lines and to the right [column] characters. Also
# accepts negative numbers.
move() {
  local instruction=""
  if [[ $1 -lt 0 ]]; then
    instruction+="\033[${1:1}A"
  elif [[ $1 -ne 0 ]]; then
    instruction+="\033[${1}B"
  fi
  if [[ $2 -lt 0 ]]; then
    instruction+="\033[${2:1}D"
  elif [[ $2 -ne 0 ]]; then
    instruction+="\033[${2}C"
  fi
  printf $instruction
}

# container(...)
# --------------
# Fit phrases inside an ASCII box, aligning them to the left of the box.
container() {
  local lines=("$@")

  local format="┌─┐│ │└─┘"
  local columns=0
  local rows=$#

  for line in "${lines[@]}"; do
    columns=$(maximum $columns $(edible "$line"))
  done
  
  local border=""
 
  for (( row = 1; row <= rows + 2; row++ )); do
    local vert=$(boundary $row $(( rows + 2 )))
 
    for (( col = 1; col <= columns + 4; col++ )); do
      local hor=$(boundary $col $(( columns + 4 )))
      local pos=$((vert * 3 + hor))
      border+=${format:pos:1}
    done
 
    border+="\n"
  done
 
  echo -en "$border"

  move -$(( rows + 2 )) 0
  move 1 0
 
  for line in "${lines[@]}"; do
    local length=$(edible "$line")
    local padding=$(( columns - length ))

    move 0 $(( padding + 2 ))
    printf '%s\n' "$line"
  done
 
  move 1 0
}
