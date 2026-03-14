#!/bin/bash

# maximum(a, b)
# -------------
# Returns the larger of two numbers.
maximum() {
  if [[ $1 -gt $2 ]]; then
    printf $1
  else
    printf $2
  fi
}


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
