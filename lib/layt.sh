#!/bin/bash

# container(...)
# --------------
# Fit phrases inside an ASCII box, aligning them to the left of the box.
container() {
  local lines=("$@")

  local format="┌─┐│ │└─┘"
  local columns=0
  local rows=$#

  for line in "${lines[@]}"; do
    columns=$(maximum $columns $(visu "$line"))
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
    local length=$(visu "$line")
    local padding=$(( columns - length ))

    move 0 $(( padding + 2 ))
    printf '%s\n' "$line"
  done
 
  move 1 0
}
